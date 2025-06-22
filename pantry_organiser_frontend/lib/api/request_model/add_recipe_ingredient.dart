import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';

class AddRecipeIngredientRequest {
  const AddRecipeIngredientRequest({
    required this.name,
    required this.quantity,
    required this.quantityUnit,
    this.recipeId,
    this.id,
  });

  final String? id;
  final String? recipeId;
  final String name;
  final double quantity;
  final QuantityUnit quantityUnit;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
      'recipeId': recipeId,
      'id': id,
    };
  }

  /// Converts the object to a JSON-encoded string
  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}
