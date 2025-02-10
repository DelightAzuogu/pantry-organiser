enum QuantityUnit {
  count,
  kilogram,
  gram,
  ounce,
  tablespoon,
  teaspoon,
  cup;

  static QuantityUnit fromString(String value) {
    return QuantityUnit.values.firstWhere(
      (unit) => unit.name.toLowerCase() == value.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid QuantityUnit: $value'),
    );
  }
}
