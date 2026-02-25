import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_recipe_details.g.dart';

@riverpod
Future<RecipeDetailsModel> getRecipeDetails(
  Ref ref, {
  required String recipeId,
}) async {
  final api = ref.watch(recipeApiProvider);

  return api.getRecipeDetails(recipeId);
}
