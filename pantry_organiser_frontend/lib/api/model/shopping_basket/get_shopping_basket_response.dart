import 'package:equatable/equatable.dart';

class GetShoppingBasketResponse extends Equatable {
  const GetShoppingBasketResponse({
    required this.id,
    required this.name,
    required this.uniqueString,
    required this.isOwner,
    required this.isClosed,
  });

  factory GetShoppingBasketResponse.fromJson(Map<String, dynamic> json) {
    return GetShoppingBasketResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      uniqueString: json['uniqueString'] as String,
      isOwner: json['isOwner'] as bool,
      isClosed: json['isClosed'] as bool,
      );
  }

  final String id;
  final String name;
  final String uniqueString;
  final bool isOwner;
  final bool isClosed;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uniqueString': uniqueString,
      'isOwner': isOwner,
      'isClosed': isClosed,
    };
  }

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, uniqueString: $uniqueString, '
        'isOwner: $isOwner, isClosed: $isClosed)';
  }

  GetShoppingBasketResponse copyWith({
    String? id,
    String? name,
    String? uniqueString,
    bool? isOwner,
    bool? isClosed,
  }) {
    return GetShoppingBasketResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      uniqueString: uniqueString ?? this.uniqueString,
      isOwner: isOwner ?? this.isOwner,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    uniqueString,
    isOwner,
    isClosed,
  ];
}
