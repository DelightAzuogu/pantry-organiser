import 'package:equatable/equatable.dart';

class GetShoppingBasketUsersResponse extends Equatable {
  const GetShoppingBasketUsersResponse({
    required this.userId,
    required this.userEmail,
    required this.basketUserId,
  });

  factory GetShoppingBasketUsersResponse.fromJson(Map<String, dynamic> json) {
    return GetShoppingBasketUsersResponse(
      userId: json['userId'] as String,
      userEmail: json['userEmail'] as String,
      basketUserId: json['basketUserId'] as String,
    );
  }

  final String userId;
  final String userEmail;
  final String basketUserId;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'basketUserId': basketUserId,
    };
  }

  @override
  String toString() {
    return 'GetShoppingBasketUsersResponse('
        'userId: $userId, userEmail: $userEmail, basketUserId: $basketUserId)';
  }

  GetShoppingBasketUsersResponse copyWith({
    String? userId,
    String? userEmail,
    String? basketUserId,
  }) {
    return GetShoppingBasketUsersResponse(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      basketUserId: basketUserId ?? this.basketUserId,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        userEmail,
        basketUserId,
      ];
}
