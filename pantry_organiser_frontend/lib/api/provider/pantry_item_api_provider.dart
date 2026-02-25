import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/service/pantry_item_api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

final pantryItemApiProvider = Provider<PantryItemApi>((ref) {
  final apiService = ref.watch(apiServiceProvider);

  return PantryItemApi(apiService);
});
