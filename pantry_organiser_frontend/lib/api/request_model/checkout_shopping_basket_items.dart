import 'dart:convert';

class CheckoutShoppingBasketItemsRequest {
  const CheckoutShoppingBasketItemsRequest({
    required this.shoppingBasketItemIds,
    required this.shoppingBasketId,
  });

  final List<String> shoppingBasketItemIds;
  final String shoppingBasketId;

  Map<String, dynamic> toJson() {
    return {
      'shoppingBasketItemIds': shoppingBasketItemIds,
      'shoppingBasketId': shoppingBasketId,
    };
  }

  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}

class UncheckoutShoppingBasketItemsRequest {
  const UncheckoutShoppingBasketItemsRequest({
    required this.shoppingBasketItemId,
    required this.shoppingBasketId,
  });

  final String shoppingBasketItemId;
  final String shoppingBasketId;

  Map<String, dynamic> toJson() {
    return {
      'shoppingBasketItemId': shoppingBasketItemId,
      'shoppingBasketId': shoppingBasketId,
    };
  }

  String toJsonEncoded() {
    return jsonEncode(toJson());
  }
}
