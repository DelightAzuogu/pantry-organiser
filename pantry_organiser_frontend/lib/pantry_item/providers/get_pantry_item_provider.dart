import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_pantry_item_provider.g.dart';

@riverpod
Future<PantryItem> getPantryItem(
  Ref ref, {
  required String itemId,
}) async {
  final api = ref.watch(pantryItemApiProvider);

  return api.getPantryItem(itemId);
}
