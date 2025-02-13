import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/api/service/pantry_item_api.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';

final pantryItemControllerProvider = StateNotifierProvider<PantryItemControllerNotifier, PantryItemState>(
  (ref) {
    final pantryItemApi = ref.watch(pantryItemApiProvider);

    return PantryItemControllerNotifier(pantryItemApi: pantryItemApi);
  },
);

class PantryItemControllerNotifier extends StateNotifier<PantryItemState> {
  PantryItemControllerNotifier({
    required this.pantryItemApi,
  }) : super(PantryItemState());

  final PantryItemApi pantryItemApi;

  Future<void> createPantryItem({
    required CreatePantryItemRequest request,
    required String pantryId,
  }) async {
    try {
      state = PantryItemState.loading();

      await pantryItemApi.createPantryItem(
        request: request,
        pantryId: pantryId,
      );

      state = PantryItemState.created();
    } catch (e) {
      state = PantryItemState(error: e.toString());
    }
  }
}
