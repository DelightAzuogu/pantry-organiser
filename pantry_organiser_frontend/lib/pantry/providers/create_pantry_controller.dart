import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class CreatePantryState {
  CreatePantryState({
    this.error,
    this.isCreated = false,
  });
  final String? error;
  final bool isCreated;

  CreatePantryState copyWith({
    String? error,
    bool? isCreated,
  }) {
    return CreatePantryState(
      isCreated: isCreated ?? this.isCreated,
      error: error ?? this.error,
    );
  }
}

final createPantryProvider = StateNotifierProvider<CreatePantryController, CreatePantryState>((ref) {
  final pantryApi = ref.watch(pantryApiProvider);

  return CreatePantryController(pantryApi: pantryApi);
});

class CreatePantryController extends StateNotifier<CreatePantryState> {
  CreatePantryController({
    required this.pantryApi,
  }) : super(CreatePantryState());

  final PantryApi pantryApi;

  Future<void> createPantry(String name) async {
    try {
      await pantryApi.createPantry(name);

      state = CreatePantryState(isCreated: true);
    } catch (e) {
      state = CreatePantryState(
        error: 'Failed to create pantry: $e',
      );
    }
  }
}
