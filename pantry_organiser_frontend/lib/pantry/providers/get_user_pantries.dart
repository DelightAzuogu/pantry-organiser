import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user_pantries.g.dart';

@riverpod
Future<List<PantriesModel>> getUserPantries(Ref ref) async {
  final pantryApi = ref.watch(pantryApiProvider);

  return pantryApi.getPantries();
}
