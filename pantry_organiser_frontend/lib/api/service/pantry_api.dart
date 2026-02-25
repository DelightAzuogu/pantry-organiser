import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

class PantryApi {
  PantryApi(this._apiService);

  final ApiService _apiService;

  final String _pantryUrl = 'pantry';

  Future<List<PantriesModel>> getPantries() async {
    try {
      final response = await _apiService.get(_pantryUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => PantriesModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get pantries');
  }

  Future<void> createPantry(String name) async {
    try {
      final body = json.encode({
        'name': name,
      });

      final response = await _apiService.post(
        '$_pantryUrl/create',
        body: body,
      );

      if (response.statusCode == 201) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to create pantry');
  }

  Future<void> deletePantry(String pantryId) async {
    try {
      final response = await _apiService.post('$_pantryUrl/$pantryId/delete');

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to delete pantry');
  }
}
