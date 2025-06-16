import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class RecipeDetailsModel extends Equatable {
  const RecipeDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.servingSize,
    required this.prepTime,
    required this.cookTime,
    required this.isOwner,
    required this.ingredients,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      servingSize: json['servingSize'] as int,
      prepTime: _parseDuration(json['prepTime']),
      cookTime: _parseDuration(json['cookTime']),
      isOwner: json['isOwner'] as bool,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => RecipeIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;
  final String? description;
  final String? instructions;
  final int servingSize;
  final Duration prepTime;
  final Duration cookTime;
  final bool isOwner;
  final List<RecipeIngredientModel> ingredients;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructions': instructions,
      'servingSize': servingSize,
      'prepTime': _formatDuration(prepTime),
      'cookTime': _formatDuration(cookTime),
      'isOwner': isOwner,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }

  static Duration _parseDuration(dynamic value) {
    if (value is int) {
      // Fallback for old format: microseconds
      return Duration(microseconds: value);
    } else if (value is String) {
      final parts = value.split(':').map(int.parse).toList();
      if (parts.length == 3) {
        return Duration(
          hours: parts[0],
          minutes: parts[1],
          seconds: parts[2],
        );
      } else {
        throw FormatException('Invalid duration string: $value');
      }
    } else {
      throw FormatException('Invalid duration format: $value');
    }
  }

  static String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inHours)}:${twoDigits(
      d.inMinutes.remainder(60),
    )}:${twoDigits(
      d.inSeconds.remainder(60),
    )}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        instructions,
        servingSize,
        prepTime,
        cookTime,
        isOwner,
        ingredients,
      ];

  @override
  String toString() => jsonEncode(toJson());
}
