// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pantry_items_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPantryItemsHash() => r'15a9a576af6b21bfd9caeeb952664865ba82bda2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getPantryItems].
@ProviderFor(getPantryItems)
const getPantryItemsProvider = GetPantryItemsFamily();

/// See also [getPantryItems].
class GetPantryItemsFamily extends Family<AsyncValue<List<PantryItem>>> {
  /// See also [getPantryItems].
  const GetPantryItemsFamily();

  /// See also [getPantryItems].
  GetPantryItemsProvider call({
    required String pantryId,
  }) {
    return GetPantryItemsProvider(
      pantryId: pantryId,
    );
  }

  @override
  GetPantryItemsProvider getProviderOverride(
    covariant GetPantryItemsProvider provider,
  ) {
    return call(
      pantryId: provider.pantryId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPantryItemsProvider';
}

/// See also [getPantryItems].
class GetPantryItemsProvider
    extends AutoDisposeFutureProvider<List<PantryItem>> {
  /// See also [getPantryItems].
  GetPantryItemsProvider({
    required String pantryId,
  }) : this._internal(
          (ref) => getPantryItems(
            ref as GetPantryItemsRef,
            pantryId: pantryId,
          ),
          from: getPantryItemsProvider,
          name: r'getPantryItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPantryItemsHash,
          dependencies: GetPantryItemsFamily._dependencies,
          allTransitiveDependencies:
              GetPantryItemsFamily._allTransitiveDependencies,
          pantryId: pantryId,
        );

  GetPantryItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pantryId,
  }) : super.internal();

  final String pantryId;

  @override
  Override overrideWith(
    FutureOr<List<PantryItem>> Function(GetPantryItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPantryItemsProvider._internal(
        (ref) => create(ref as GetPantryItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pantryId: pantryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PantryItem>> createElement() {
    return _GetPantryItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPantryItemsProvider && other.pantryId == pantryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pantryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPantryItemsRef on AutoDisposeFutureProviderRef<List<PantryItem>> {
  /// The parameter `pantryId` of this provider.
  String get pantryId;
}

class _GetPantryItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<PantryItem>>
    with GetPantryItemsRef {
  _GetPantryItemsProviderElement(super.provider);

  @override
  String get pantryId => (origin as GetPantryItemsProvider).pantryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
