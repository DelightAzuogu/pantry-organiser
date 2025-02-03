import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/service/service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final apiService = ref.watch(apiServiceProvider);

  return AuthApi(apiService);
});
