import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/helpers/showCustomToast.dart';
import 'package:pantry_organiser_frontend/service/service.dart';

final authenticationControllerProvider = StateNotifierProvider<AuthenticationController, AuthState>((ref) {
  final userService = ref.watch(userServiceProvider);
  final authApi = ref.watch(authApiProvider);

  return AuthenticationController(
    userService: userService,
    authApi: authApi,
  );
});

class AuthenticationController extends StateNotifier<AuthState> {
  AuthenticationController({
    required this.userService,
    required this.authApi,
  }) : super(const AuthState.unAuthenticated()) {
    _initialize();
  }
  final UserService userService;
  final AuthApi authApi;

  /// Asynchronously fetch the logged-in user and update the state.
  Future<void> _initialize() async {
    final currentUser = await userService.getLoggedInUser();
    if (currentUser != null) {
      state = AuthState.authenticated(authenticatedUser: currentUser);
    }
  }

  /// sign in the user by storing credentials and updating state.
  Future<void> login(String email, String password) async {
    try {
      final response = await authApi.login(email, password);

      state = AuthState.authenticated(
        authenticatedUser: User(
          token: response.jwtModel.accessToken,
          email: email,
          id: response.id,
        ),
      );
    } catch (e) {
      state = const AuthState.unAuthenticated();

      await showCustomToast(
        message: 'Failed to login',
      );

      rethrow;
    }
  }

  /// Registers the user by storing credentials and updating state.
  Future<void> register(String email, String password) async {
    try {
      final response = await authApi.register(email, password);

      state = AuthState.authenticated(
        authenticatedUser: User(
          token: response.jwtModel.accessToken,
          email: email,
          id: response.id,
        ),
      );
    } catch (e) {
      state = const AuthState.unAuthenticated();

      await showCustomToast(
        message: 'Failed to register',
      );

      rethrow;
    }
  }

  /// Logs out the user by clearing stored credentials and updating state.
  Future<void> logout() async {
    try {
      await userService.deleteUser();
      state = const AuthState.unAuthenticated();
    } catch (e) {
      await showCustomToast(
        message: 'Failed to logout',
      );

      rethrow;
    }
  }
}
