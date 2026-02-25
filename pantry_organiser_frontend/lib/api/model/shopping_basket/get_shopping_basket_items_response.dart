import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class GetShoppingBasketItemResponse extends Equatable {
  const GetShoppingBasketItemResponse({
    required this.id,
    required this.name,
    required this.quantity,
    required this.quantityUnit,
    required this.isChecked,
  });

  factory GetShoppingBasketItemResponse.fromJson(Map<String, dynamic> json) {
    return GetShoppingBasketItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      quantityUnit: QuantityUnit.fromString(json['quantityUnit'] as String),
      isChecked: json['isChecked'] as bool? ?? false,
    );
  }

  final String id;
  final String name;
  final int quantity;
  final QuantityUnit quantityUnit;
  final bool isChecked;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
      'isChecked': isChecked,
    };
  }

  GetShoppingBasketItemResponse copyWith({
    String? id,
    String? name,
    int? quantity,
    QuantityUnit? quantityUnit,
    bool? isChecked,
  }) {
    return GetShoppingBasketItemResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        quantity,
        quantityUnit,
        isChecked,
      ];

  @override
  String toString() {
    return 'GetShoppingBasketItemResponse(id: $id, name: $name, '
        'quantity: $quantity, quantityUnit: ${quantityUnit.name}, '
        'isChecked: $isChecked)';
  }
}
