import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_pantry_items_providers.g.dart';

@riverpod
Future<List<PantryItem>> getPantryItems(
  Ref ref, {
  required String pantryId,
}) async {
  final api = ref.watch(pantryItemApiProvider);

  return api.getPantryItems(pantryId);
}
