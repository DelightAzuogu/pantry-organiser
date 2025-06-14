import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

final recipeApiProvider = Provider<RecipeApi>((ref) {
  final apiService = ref.watch(apiServiceProvider);

  return RecipeApi(apiService);
});
