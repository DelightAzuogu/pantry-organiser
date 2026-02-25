// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pantry_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPantryItemHash() => r'3d9c0581ae738291b30c3f1028151f2341b633ee';

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

/// See also [getPantryItem].
@ProviderFor(getPantryItem)
const getPantryItemProvider = GetPantryItemFamily();

/// See also [getPantryItem].
class GetPantryItemFamily extends Family<AsyncValue<PantryItem>> {
  /// See also [getPantryItem].
  const GetPantryItemFamily();

  /// See also [getPantryItem].
  GetPantryItemProvider call({
    required String itemId,
  }) {
    return GetPantryItemProvider(
      itemId: itemId,
    );
  }

  @override
  GetPantryItemProvider getProviderOverride(
    covariant GetPantryItemProvider provider,
  ) {
    return call(
      itemId: provider.itemId,
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
  String? get name => r'getPantryItemProvider';
}

/// See also [getPantryItem].
class GetPantryItemProvider extends AutoDisposeFutureProvider<PantryItem> {
  /// See also [getPantryItem].
  GetPantryItemProvider({
    required String itemId,
  }) : this._internal(
          (ref) => getPantryItem(
            ref as GetPantryItemRef,
            itemId: itemId,
          ),
          from: getPantryItemProvider,
          name: r'getPantryItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPantryItemHash,
          dependencies: GetPantryItemFamily._dependencies,
          allTransitiveDependencies:
              GetPantryItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  GetPantryItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<PantryItem> Function(GetPantryItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPantryItemProvider._internal(
        (ref) => create(ref as GetPantryItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PantryItem> createElement() {
    return _GetPantryItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPantryItemProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPantryItemRef on AutoDisposeFutureProviderRef<PantryItem> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _GetPantryItemProviderElement
    extends AutoDisposeFutureProviderElement<PantryItem> with GetPantryItemRef {
  _GetPantryItemProviderElement(super.provider);

  @override
  String get itemId => (origin as GetPantryItemProvider).itemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
