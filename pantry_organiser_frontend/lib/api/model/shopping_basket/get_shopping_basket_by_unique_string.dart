import 'package:equatable/equatable.dart';

class GetShoppingBasketByUniqueStringResponse extends Equatable {
  const GetShoppingBasketByUniqueStringResponse({
    required this.id,
    required this.name,
    required this.uniqueString,
    required this.isOwner,
    required this.isClosed,
    required this.ownerName,
  });

  factory GetShoppingBasketByUniqueStringResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetShoppingBasketByUniqueStringResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      uniqueString: json['uniqueString'] as String,
      isOwner: json['isOwner'] as bool,
      isClosed: json['isClosed'] as bool,
      ownerName: json['ownerName'] as String,
    );
  }

  final String id;
  final String name;
  final String uniqueString;
  final bool isOwner;
  final bool isClosed;
  final String ownerName;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uniqueString': uniqueString,
      'isOwner': isOwner,
      'isClosed': isClosed,
      'ownerName': ownerName,
    };
  }

  @override
  String toString() {
    return 'GetShoppingBasketByUniqueStringResponse('
        'id: $id, name: $name, uniqueString: $uniqueString, '
        'isOwner: $isOwner, isClosed: $isClosed, ownerName: $ownerName)';
  }

  GetShoppingBasketByUniqueStringResponse copyWith({
    String? id,
    String? name,
    String? uniqueString,
    bool? isOwner,
    bool? isClosed,
    String? ownerName,
  }) {
    return GetShoppingBasketByUniqueStringResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      uniqueString: uniqueString ?? this.uniqueString,
      isOwner: isOwner ?? this.isOwner,
      isClosed: isClosed ?? this.isClosed,
      ownerName: ownerName ?? this.ownerName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        uniqueString,
        isOwner,
        isClosed,
        ownerName,
      ];
}
