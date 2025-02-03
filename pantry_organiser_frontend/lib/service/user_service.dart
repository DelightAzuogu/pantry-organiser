import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/storage/storage.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final flutterSecureStorage = ref.watch(flutterSecureStorageProvider);
  return UserService(flutterSecureStorage: flutterSecureStorage);
});

class UserService {
  const UserService({
    required this.flutterSecureStorage,
  });

  final FlutterSecureStorage flutterSecureStorage;

  /// Retrieves the currently logged-in user from secure storage.
  Future<User?> getLoggedInUser() async {
    try {
      final userJson = await flutterSecureStorage.read(key: 'user');
      if (userJson != null) {
        return User.decode(userJson);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  /// Stores the Firebase user into secure storage.
  Future<void> storeUser(User user) async {
    try {
      await flutterSecureStorage.write(key: 'user', value: user.encode());
    } catch (e) {
      throw Exception('Error storing user: $e');
    }
  }

  /// Deletes the stored user from secure storage.
  Future<void> deleteUser() async {
    try {
      await flutterSecureStorage.delete(key: 'user');
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
