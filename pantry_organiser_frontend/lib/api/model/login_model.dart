import 'package:pantry_organiser_frontend/api/api.dart';

class LoginModel {
  LoginModel({
    required this.id,
    required this.email,
    required this.jwtModel,
  });

  // Factory constructor to create a LoginModel from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'] as String,
      email: json['email'] as String,
      jwtModel: JwtModel.fromJson(json['token'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String email;
  final JwtModel jwtModel;

  @override
  String toString() => 'LoginModel(id: $id, email: $email, jwtModel: $jwtModel)';
}
