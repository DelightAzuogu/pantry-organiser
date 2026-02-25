import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

final geminiRecommendationControllerProvider = StateNotifierProvider<
    GeminiRecommendationController, GeminiRecommendationState>((ref) {
  final api = ref.watch(recipeApiProvider);
  return GeminiRecommendationController(recipeApi: api);
});

class GeminiRecommendationController
    extends StateNotifier<GeminiRecommendationState> {
  GeminiRecommendationController({required this.recipeApi})
      : super(const GeminiRecommendationState.initial());

  final RecipeApi recipeApi;

  Future<void> getRecommendation({
    List<String>? pantryIds, // optional
    String? instructionPrompt, // optional
  }) async {
    final pantryList = pantryIds ?? [];

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await recipeApi.getRecipeFromGemini(
        pantryIds: pantryList,
        instructionPrompt: instructionPrompt?.trim().isEmpty ?? true
            ? null
            : instructionPrompt,
      );

      final entry = GeminiRecommendationEntry(
        text: result,
        pantries: pantryList,
        instruction: instructionPrompt,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        recommendations: [...state.recommendations, entry],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearRecommendations() {
    state = const GeminiRecommendationState.initial();
  }
}

// State
class GeminiRecommendationState {
  final List<GeminiRecommendationEntry> recommendations;
  final bool isLoading;
  final String? error;

  const GeminiRecommendationState({
    required this.recommendations,
    required this.isLoading,
    required this.error,
  });

  const GeminiRecommendationState.initial()
      : recommendations = const <GeminiRecommendationEntry>[],
        isLoading = false,
        error = null;

  GeminiRecommendationState copyWith({
    List<GeminiRecommendationEntry>? recommendations,
    bool? isLoading,
    String? error,
  }) {
    return GeminiRecommendationState(
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Recommendation entry model
class GeminiRecommendationEntry {
  final String text;
  final List<String> pantries;
  final String? instruction;
  final DateTime timestamp;

  const GeminiRecommendationEntry({
    required this.text,
    required this.pantries,
    this.instruction,
    required this.timestamp,
  });
}
