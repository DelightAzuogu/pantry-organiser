import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated({
    required User authenticatedUser,
  }) = _Authenticated;

  const factory AuthState.unAuthenticated() = _UnAuthenticated;
}
