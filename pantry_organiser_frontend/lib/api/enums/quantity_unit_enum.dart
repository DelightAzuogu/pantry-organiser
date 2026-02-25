enum QuantityUnit {
  count('ct'),
  kilogram('kg'),
  gram('g'),
  ounce('oz'),
  tablespoon('tbsp'),
  teaspoon('tsp'),
  cup('cup');

  const QuantityUnit(this.shortForm);
  final String shortForm;

  static QuantityUnit fromString(String value) {
    return QuantityUnit.values.firstWhere(
      (unit) => unit.name.toLowerCase() == value.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid QuantityUnit: $value'),
    );
  }
}
