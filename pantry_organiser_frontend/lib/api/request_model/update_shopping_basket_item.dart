import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';

class UpdateShoppingBasketItemRequest {
  const UpdateShoppingBasketItemRequest({
    required this.id,
    required this.name,
    required this.quantity,
    required this.quantityUnit,
  });

  final String id;
  final String name;
  final int quantity;
  final QuantityUnit quantityUnit;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
    };
  }

  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}
