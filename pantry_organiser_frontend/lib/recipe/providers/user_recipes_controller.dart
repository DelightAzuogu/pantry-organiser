import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
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

  Future<void> getRecipes({bool? isCreated, bool? isDeleted}) async {
    state = const UserRecipeControllerState.loading();

    try {
      final recipes = await recipeApi.getUserRecipes();
      state = UserRecipeControllerState.success(
        recipes,
        isCreated: isCreated ?? false,
        isDeleted: isDeleted ?? false,
      );
    } catch (e) {
      state = const UserRecipeControllerState.error('Failed to fetch recipes');
    }
  }

  Future<void> createRecipe(AddRecipeRequest request) async {
    try {
      await recipeApi.createRecipe(request: request);

      await showCustomToast(
        message: 'Recipe created successfully',
      );

      await getRecipes(isCreated: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to create recipe');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await recipeApi.deleteRecipe(recipeId);

      await showCustomToast(
        message: 'Recipe deleted successfully',
      );

      await getRecipes(isDeleted: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to delete recipe');
    }
  }
}
