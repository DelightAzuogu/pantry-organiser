import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/api/provider/shopping_basket_api.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/shopping_basket/providers/shopping_basket_controller_state.dart';

final shoppingBasketControllerProvider = StateNotifierProvider<
    ShoppingBasketController, ShoppingBasketControllerState>((ref) {
  final shoppingBasketApi = ref.watch(shoppingBasketApiProvider);

  return ShoppingBasketController(shoppingBasketApi: shoppingBasketApi);
});

class ShoppingBasketController
    extends StateNotifier<ShoppingBasketControllerState> {
  ShoppingBasketController({
    required this.shoppingBasketApi,
  }) : super(const ShoppingBasketControllerState());

  final ShoppingBasketApi shoppingBasketApi;

  Future<void> getOpenShoppingBaskets({
    bool? isCreated,
    bool? isDeleted,
    bool? isUpdated,
    bool? isClosed,
  }) async {
    state = const ShoppingBasketControllerState.loading();

    try {
      final baskets = await shoppingBasketApi.getOpenShoppingBaskets();
      state = ShoppingBasketControllerState.success(
        baskets,
        isCreated: isCreated ?? false,
        isDeleted: isDeleted ?? false,
        isUpdated: isUpdated ?? false,
        isClosed: isClosed ?? false,
      );
    } catch (e) {
      state = const ShoppingBasketControllerState.error(
        'Failed to fetch shopping baskets',
      );
    }
  }

  Future<void> createShoppingBasket(String name) async {
    try {
      await shoppingBasketApi.createShoppingBasket(name);

      await showCustomToast(
        message: 'Shopping basket created successfully',
      );

      await getOpenShoppingBaskets(isCreated: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to create shopping basket');
    }
  }

  Future<void> deleteShoppingBasket(String basketId) async {
    try {
      await shoppingBasketApi.deleteShoppingBasket(basketId);

      await showCustomToast(
        message: 'Shopping basket deleted successfully',
      );

      await getOpenShoppingBaskets(isDeleted: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to delete shopping basket');
    }
  }

  Future<void> updateShoppingBasket(String basketId, String name) async {
    try {
      await shoppingBasketApi.updateShoppingBasket(basketId, name);

      await showCustomToast(
        message: 'Shopping basket updated successfully',
      );

      await getOpenShoppingBaskets(isUpdated: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to update shopping basket');
    }
  }

  Future<void> closeShoppingBasket(String basketId) async {
    try {
      await shoppingBasketApi.closeShoppingBasket(basketId);

      await showCustomToast(
        message: 'Shopping basket closed successfully',
      );

      await getOpenShoppingBaskets(isClosed: true);
    } catch (e) {
      await showCustomToast(message: 'Failed to close shopping basket');
    }
  }
}
