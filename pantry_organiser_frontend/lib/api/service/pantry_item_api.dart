import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

class PantryItemApi {
  PantryItemApi(this._apiService);

  final ApiService _apiService;

  final String _pantryUrl = 'pantry';

  Future<List<PantryItem>> getPantryItems(String pantryId) async {
    try {
      final response = await _apiService.get('$_pantryUrl/$pantryId/items');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => PantryItem.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get pantry items');
  }

  Future<PantryItem> getPantryItem(String itemId) async {
    try {
      final response = await _apiService.get('$_pantryUrl/item/$itemId');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return PantryItem.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get pantry item');
  }

  Future<void> createPantryItem({
    required CreatePantryItemRequest request,
    required String pantryId,
  }) async {
    try {
      final response = await _apiService.post(
        '$_pantryUrl/$pantryId/add',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 201) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to create pantry item');
  }

  Future<void> updatePantryItem({
    required String itemId,
    required CreatePantryItemRequest request,
  }) async {
    try {
      final response = await _apiService.post(
        '$_pantryUrl/item/$itemId/update',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to update pantry item');
  }

  Future<void> deletePantryItem(String itemId) async {
    try {
      final response = await _apiService.post('$_pantryUrl/item/$itemId/delete');

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to delete pantry item');
  }
}
