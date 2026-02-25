import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

final selectedPantryProvider = StateProvider<PantriesModel?>(
  (ref) => null,
);
