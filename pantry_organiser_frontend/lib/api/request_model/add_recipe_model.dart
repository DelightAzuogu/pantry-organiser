import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';

class AddRecipeRequest {
  const AddRecipeRequest({
    required this.name,
    required this.servingSize,
    required this.prepTime,
    required this.cookTime,
    required this.ingredients,
    this.description,
    this.instructions,
  });

  final String name;
  final String? description;
  final String? instructions;
  final int servingSize;
  final Duration prepTime;
  final Duration cookTime;
  final List<AddRecipeIngredientRequest> ingredients;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'instructions': instructions,
      'servingSize': servingSize,
      'prepTimeString': prepTime.toString(),
      'cookTimeString': cookTime.toString(),
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }

  /// Converts the object to a JSON-encoded string
  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}
