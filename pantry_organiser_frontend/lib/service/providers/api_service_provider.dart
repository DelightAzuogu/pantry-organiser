import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

final apiServiceProvider = StateNotifierProvider<ApiServiceNotifier, ApiService>((ref) {
  final userService = ref.watch(userServiceProvider);

  // Initialize the ApiServiceNotifier with UserService
  return ApiServiceNotifier(userService: userService);
});

class ApiServiceNotifier extends StateNotifier<ApiService> {
  ApiServiceNotifier({
    required this.userService,
  }) : super(ApiService('')) {
    _initializeApiService();
  }

  final UserService userService;

  Future<void> _initializeApiService() async {
    try {
      final user = await userService.getLoggedInUser();
      if (user != null) {
        state = ApiService(user.token);
      } else {
        state = ApiService('');
      }
    } catch (e) {
      state = ApiService('');
    }
  }
}
