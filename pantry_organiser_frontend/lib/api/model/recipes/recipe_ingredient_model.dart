import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class RecipeIngredientModel extends Equatable {
  const RecipeIngredientModel({
    required this.name,
    required this.id,
    required this.quantity,
    required this.quantityUnit,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      name: json['name'] as String,
      id: json['id'] as String,
      quantity: (json['quantity'] is int) ? (json['quantity'] as int).toDouble() : json['quantity'] as double,
      quantityUnit: QuantityUnit.fromString(json['quantityUnit'] as String),
    );
  }

  final String name;
  final String id;
  final double quantity;
  final QuantityUnit quantityUnit;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  List<Object?> get props => [
        name,
        id,
        quantity,
        quantityUnit,
      ];
}
