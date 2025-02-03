class JwtModel {
  JwtModel({
    required this.accessToken,
  });

  // Create JwtModel from JSON
  factory JwtModel.fromJson(Map<String, dynamic> json) {
    final token = json['access_token'] ?? '';

    return JwtModel(
      accessToken: token as String,
    );
  }
  final String accessToken;
}
