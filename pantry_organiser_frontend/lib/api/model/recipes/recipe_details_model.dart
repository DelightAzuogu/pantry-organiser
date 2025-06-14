import 'dart:convert';

import 'package:equatable/equatable.dart';

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
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      instructions: json['instructions'] as String,
      servingSize: json['servingSize'] as int,
      prepTime: Duration(microseconds: json['prepTime'] as int),
      cookTime: Duration(microseconds: json['cookTime'] as int),
      isOwner: json['isOwner'] as bool,
    );
  }

  final String id;
  final String name;
  final String description;
  final String instructions;
  final int servingSize;
  final Duration prepTime;
  final Duration cookTime;
  final bool isOwner;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructions': instructions,
      'servingSize': servingSize,
      'prepTime': prepTime.inMicroseconds,
      'cookTime': cookTime.inMicroseconds,
      'isOwner': isOwner,
    };
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
      ];

  @override
  String toString() => jsonEncode(toJson());
}
