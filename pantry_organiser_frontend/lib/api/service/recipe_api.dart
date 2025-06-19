import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

class RecipeApi {
  RecipeApi(this._apiService);

  final ApiService _apiService;

  final String _recipeUrl = 'recipes';

  Future<void> createRecipe({
    required AddRecipeRequest request,
  }) async {
    try {
      final requestBody = request.toJsonEncoded();

      final response = await _apiService.post(
        '$_recipeUrl/create',
        body: requestBody,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to create recipe');
  }

  Future<List<RecipesModel>> getUserRecipes() async {
    try {
      final response = await _apiService.get(
        '$_recipeUrl/all',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (json) => RecipesModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to fetch user recipes');
  }

  Future<RecipeDetailsModel> getRecipeDetails(String recipeId) async {
    try {
      final response = await _apiService.get(
        '$_recipeUrl/$recipeId',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return RecipeDetailsModel.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to fetch recipe details');
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      final response = await _apiService.post(
        '$_recipeUrl/$recipeId/delete',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to delete recipe');
  }
}
