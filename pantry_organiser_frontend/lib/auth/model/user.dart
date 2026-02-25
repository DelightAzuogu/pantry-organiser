import 'dart:convert';

class User {
  User({
    required this.id,
    required this.email,
    required this.token,
  });

  // Factory constructor to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }

  final String id;
  final String email;
  final String token;

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
    };
  }

  // Decode from JSON string
  factory User.decode(String str) {
    return User.fromJson(json.decode(str) as Map<String, dynamic>);
  }

  String encode() => json.encode(toJson());

  @override
  String toString() => 'User(id: $id, email: $email, token: $token)';
}
