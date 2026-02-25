import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';

class AddItemToShoppingBasket {
  const AddItemToShoppingBasket({
    required this.name,
    required this.quantity,
    required this.quantityUnit,
    required this.shoppingBasketId,
  });

  final String name;
  final int quantity;
  final QuantityUnit quantityUnit;
  final String shoppingBasketId;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
      'shoppingBasketId': shoppingBasketId,
    };
  }

  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}
