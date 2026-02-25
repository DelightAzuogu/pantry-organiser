import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

final selectedRecipeIdProvider = StateProvider<String?>(
  (ref) => null,
);

final selectedRecipeProvider = StateProvider<RecipeDetailsModel?>(
  (ref) => null,
);
