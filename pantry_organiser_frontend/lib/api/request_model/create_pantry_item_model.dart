import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';

class CreatePantryItemRequest {
  const CreatePantryItemRequest({
    required this.name,
    required this.quantity,
    required this.quantityUnit,
    this.description,
    this.brand,
    this.expiryDate,
  });

  final String name;
  final String? description;
  final double quantity;
  final QuantityUnit quantityUnit;
  final String? brand;
  final DateTime? expiryDate;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
      'brand': brand,
      'expiryDate': expiryDate?.toIso8601String(),
    };
  }

  /// Converts the object to a JSON-encoded string
  String toJsonEncoded() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'CreatePantryItemRequest(name: $name, description: $description, quantity: $quantity, quantityUnit: $quantityUnit, brand: $brand, expiryDate: $expiryDate)';
  }
}
