import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_by_unique_string.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_items_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_users_response.dart';
import 'package:pantry_organiser_frontend/api/provider/shopping_basket_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_basket_providers.g.dart';

/// --- 🛒 CREATE SHOPPING BASKET ---
@riverpod
Future<void> createShoppingBasket(
  Ref ref,
  String basketName,
) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.createShoppingBasket(basketName);
}

/// --- 📦 GET SINGLE BASKET BY ID ---
@riverpod
Future<GetShoppingBasketResponse> getShoppingBasket(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getShoppingBasket(basketId);
}

/// --- 📂 GET OPEN SHOPPING BASKETS ---
@riverpod
Future<List<GetShoppingBasketResponse>> getUserOpenShoppingBaskets(
  Ref ref,
) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getOpenShoppingBaskets();
}

/// --- 📁 GET CLOSED SHOPPING BASKETS ---
@riverpod
Future<List<GetShoppingBasketResponse>> getUserClosedShoppingBaskets(
  Ref ref,
) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getClosedShoppingBaskets();
}

/// --- 🗑️ DELETE SHOPPING BASKET ---
@riverpod
Future<void> deleteShoppingBasket(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.deleteShoppingBasket(basketId);
}

/// --- ✏️ UPDATE SHOPPING BASKET NAME ---
@riverpod
Future<void> updateShoppingBasket(
  Ref ref, {
  required String basketId,
  required String basketName,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.updateShoppingBasket(basketId, basketName);
}

/// --- 🔗 GET BASKET BY UNIQUE STRING ---
@riverpod
Future<GetShoppingBasketByUniqueStringResponse> getShoppingBasketByUniqueString(
  Ref ref, {
  required String uniqueString,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getShoppingBasketByUniqueString(uniqueString);
}

/// --- 🚪 CLOSE SHOPPING BASKET ---
@riverpod
Future<void> closeShoppingBasket(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.closeShoppingBasket(basketId);
}

/// --- ➕ ADD ITEM TO SHOPPING BASKET ---
@riverpod
Future<void> addItemToShoppingBasket(
  Ref ref, {
  required AddItemToShoppingBasket request,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.addItemToShoppingBasket(request);
}

/// --- 🧾 GET SHOPPING BASKET ITEM ---
@riverpod
Future<GetShoppingBasketItemResponse> getShoppingBasketItem(
  Ref ref, {
  required String itemId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getShoppingBasketItem(itemId);
}

/// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
@riverpod
Future<void> checkoutShoppingBasketItems(
  Ref ref, {
  required CheckoutShoppingBasketItemsRequest request,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.checkoutShoppingBasketItem(request);
}

/// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
@riverpod
Future<void> deleteShoppingBasketItem(
  Ref ref, {
  required String itemId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.deleteShoppingBasketItem(itemId);
}

/// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
@riverpod
Future<void> updateShoppingBasketItem(
  Ref ref, {
  required UpdateShoppingBasketItemRequest request,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.updateShoppingBasketItem(request);
}

/// --- 👥 GET SHOPPING BASKET USERS ---
@riverpod
Future<List<GetShoppingBasketUsersResponse>> getShoppingBasketUsers(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getShoppingBasketUsers(basketId);
}

/// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
@riverpod
Future<void> removeUserFromShoppingBasket(
  Ref ref, {
  required String basketId,
  required String userId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.removeUserFromShoppingBasket(basketId: basketId, userId: userId);
}

/// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
@riverpod
Future<void> joinShoppingBasketByUniqueString(
  Ref ref, {
  required String uniqueString,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.joinShoppingBasketByUniqueString(uniqueString);
}

/// --- 🚪 LEAVE SHOPPING BASKET ---
@riverpod
Future<void> leaveShoppingBasket(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.leaveShoppingBasket(basketId);
}

/// --- 📋 GET SHOPPING BASKET ITEMS ---
@riverpod
Future<List<GetShoppingBasketItemResponse>> getShoppingBasketItems(
  Ref ref, {
  required String basketId,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.getShoppingBasketItems(basketId);
}

@riverpod
Future<void> uncheckoutShoppingBasketItem(
  Ref ref, {
  required UncheckoutShoppingBasketItemsRequest request,
}) async {
  final api = ref.watch(shoppingBasketApiProvider);
  return api.uncheckoutShoppingBasketItem(request);
}

final selectedShoppingBasketProvider =
    StateProvider<GetShoppingBasketResponse?>(
  (ref) => null,
);
