import 'dart:convert';

import 'package:equatable/equatable.dart';

class PantriesModel extends Equatable {
  const PantriesModel({
    required this.name,
    required this.id,
  });

  factory PantriesModel.fromJson(Map<String, dynamic> json) {
    return PantriesModel(
      name: json['name'] as String,
      id: json['id'] as String,
    );
  }

  final String name;
  final String id;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  String toString() => jsonEncode(toJson());

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
