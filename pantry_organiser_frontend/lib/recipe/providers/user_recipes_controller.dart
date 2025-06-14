import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';

final userRecipesControllerProvider = StateNotifierProvider<UserRecipesController, UserRecipeControllerState>((
  ref,
) {
  final recipeApi = ref.watch(recipeApiProvider);

  return UserRecipesController(recipeApi: recipeApi);
});

class UserRecipesController extends StateNotifier<UserRecipeControllerState> {
  UserRecipesController({
    required this.recipeApi,
  }) : super(const UserRecipeControllerState());

  final RecipeApi recipeApi;

  Future<void> getRecipes() async {
    state = const UserRecipeControllerState.loading();

    try {
      final recipes = await recipeApi.getUserRecipes();
      state = UserRecipeControllerState.success(recipes);
    } catch (e) {
      state = const UserRecipeControllerState.error('Failed to fetch recipes');
    }
  }
}
