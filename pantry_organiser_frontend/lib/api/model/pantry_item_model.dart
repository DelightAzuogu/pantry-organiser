import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class PantryItem extends Equatable {
  const PantryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.quantityUnit,
    this.description,
    this.brand,
    this.expiryDate,
  });

  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      quantity: (json['quantity'] is int) ? (json['quantity'] as int).toDouble() : json['quantity'] as double,
      quantityUnit: QuantityUnit.fromString(json['quantityUnit'] as String),
      brand: json['brand'] as String?,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate'] as String) : null,
    );
  }

  final String id;
  final String name;
  final String? description;
  final double quantity;
  final QuantityUnit quantityUnit;
  final String? brand;
  final DateTime? expiryDate;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'quantityUnit': quantityUnit.name,
      'brand': brand,
      'expiryDate': expiryDate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, description: $description, '
        'quantity: $quantity, quantityUnit: $quantityUnit, brand: $brand, '
        'expiryDate: $expiryDate)';
  }

  PantryItem copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    QuantityUnit? quantityUnit,
    String? brand,
    DateTime? expiryDate,
  }) {
    return PantryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      brand: brand ?? this.brand,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        quantityUnit,
        brand,
        expiryDate,
      ];
}
