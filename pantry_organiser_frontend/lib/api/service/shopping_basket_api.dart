import 'dart:convert';

import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_by_unique_string.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_items_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_users_response.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

class ShoppingBasketApi {
  ShoppingBasketApi(this._apiService);

  final ApiService _apiService;

  final String _shoppingBasketUrl = 'shopping-baskets';

  Future<void> createShoppingBasket(String name) async {
    final body = jsonEncode(name);

    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/create',
        body: body,
      );

      if (response.statusCode == 201) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to create shopping basket');
  }

  Future<GetShoppingBasketResponse> getShoppingBasket(String basketId) async {
    try {
      final response = await _apiService.get('$_shoppingBasketUrl/$basketId');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return GetShoppingBasketResponse.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get shopping basket');
  }

  Future<List<GetShoppingBasketResponse>> getOpenShoppingBaskets() async {
    try {
      final response = await _apiService.get('$_shoppingBasketUrl/open');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => GetShoppingBasketResponse.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get open shopping baskets');
  }

  Future<List<GetShoppingBasketResponse>> getClosedShoppingBaskets() async {
    try {
      final response = await _apiService.get('$_shoppingBasketUrl/closed');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => GetShoppingBasketResponse.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get closed shopping baskets');
  }

  Future<void> deleteShoppingBasket(String basketId) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$basketId/delete',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to delete shopping basket');
  }

  Future<void> updateShoppingBasket(
    String basketId,
    String name,
  ) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$basketId/update',
        body: jsonEncode(name),
      );

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to update shopping basket');
  }

  Future<GetShoppingBasketByUniqueStringResponse>
      getShoppingBasketByUniqueString(
    String uniqueString,
  ) async {
    try {
      final response =
          await _apiService.get('$_shoppingBasketUrl/unique/$uniqueString');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return GetShoppingBasketByUniqueStringResponse.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get shopping basket by unique string');
  }

  Future<void> closeShoppingBasket(String basketId) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$basketId/close',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to close shopping basket');
  }

  Future<void> addItemToShoppingBasket(AddItemToShoppingBasket request) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/items/add',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to add item to shopping basket');
  }

  Future<GetShoppingBasketItemResponse> getShoppingBasketItem(
    String itemId,
  ) async {
    try {
      final response =
          await _apiService.get('$_shoppingBasketUrl/items/$itemId');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return GetShoppingBasketItemResponse.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get shopping basket item');
  }

  Future<void> checkoutShoppingBasketItem(
    CheckoutShoppingBasketItemsRequest request,
  ) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/items/checkout',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to checkout shopping basket item');
  }

  Future<void> deleteShoppingBasketItem(String itemId) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/items/delete/$itemId',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to delete shopping basket item');
  }

  Future<void> updateShoppingBasketItem(
    UpdateShoppingBasketItemRequest request,
  ) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/items/update',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to update shopping basket item');
  }

  Future<List<GetShoppingBasketUsersResponse>> getShoppingBasketUsers(
    String basketId,
  ) async {
    try {
      final response =
          await _apiService.get('$_shoppingBasketUrl/$basketId/users');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => GetShoppingBasketUsersResponse.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get shopping basket users');
  }

  Future<void> removeUserFromShoppingBasket({
    required String basketId,
    required String userId,
  }) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$basketId/users/remove',
        body: jsonEncode(userId),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to remove user from shopping basket');
  }

  Future<void> joinShoppingBasketByUniqueString(String uniqueString) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$uniqueString/join',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to join shopping basket');
  }

  Future<void> leaveShoppingBasket(String basketId) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/$basketId/leave',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to leave shopping basket');
  }

  Future<List<GetShoppingBasketItemResponse>> getShoppingBasketItems(
    String basketId,
  ) async {
    try {
      final response =
          await _apiService.get('$_shoppingBasketUrl/$basketId/items');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data
            .map(
              (e) => GetShoppingBasketItemResponse.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to get shopping basket items');
  }

  Future<void> uncheckoutShoppingBasketItem(
    UncheckoutShoppingBasketItemsRequest request,
  ) async {
    try {
      final response = await _apiService.post(
        '$_shoppingBasketUrl/items/uncheckout',
        body: request.toJsonEncoded(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to uncheckout shopping basket items');
  }
}
