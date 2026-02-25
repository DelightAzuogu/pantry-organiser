// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recipe_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRecipeDetailsHash() => r'1edf355304118fbaedc2f7b67471302c88970aef';

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

/// See also [getRecipeDetails].
@ProviderFor(getRecipeDetails)
const getRecipeDetailsProvider = GetRecipeDetailsFamily();

/// See also [getRecipeDetails].
class GetRecipeDetailsFamily extends Family<AsyncValue<RecipeDetailsModel>> {
  /// See also [getRecipeDetails].
  const GetRecipeDetailsFamily();

  /// See also [getRecipeDetails].
  GetRecipeDetailsProvider call({
    required String recipeId,
  }) {
    return GetRecipeDetailsProvider(
      recipeId: recipeId,
    );
  }

  @override
  GetRecipeDetailsProvider getProviderOverride(
    covariant GetRecipeDetailsProvider provider,
  ) {
    return call(
      recipeId: provider.recipeId,
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
  String? get name => r'getRecipeDetailsProvider';
}

/// See also [getRecipeDetails].
class GetRecipeDetailsProvider
    extends AutoDisposeFutureProvider<RecipeDetailsModel> {
  /// See also [getRecipeDetails].
  GetRecipeDetailsProvider({
    required String recipeId,
  }) : this._internal(
          (ref) => getRecipeDetails(
            ref as GetRecipeDetailsRef,
            recipeId: recipeId,
          ),
          from: getRecipeDetailsProvider,
          name: r'getRecipeDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRecipeDetailsHash,
          dependencies: GetRecipeDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetRecipeDetailsFamily._allTransitiveDependencies,
          recipeId: recipeId,
        );

  GetRecipeDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipeId,
  }) : super.internal();

  final String recipeId;

  @override
  Override overrideWith(
    FutureOr<RecipeDetailsModel> Function(GetRecipeDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRecipeDetailsProvider._internal(
        (ref) => create(ref as GetRecipeDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipeId: recipeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<RecipeDetailsModel> createElement() {
    return _GetRecipeDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRecipeDetailsProvider && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetRecipeDetailsRef on AutoDisposeFutureProviderRef<RecipeDetailsModel> {
  /// The parameter `recipeId` of this provider.
  String get recipeId;
}

class _GetRecipeDetailsProviderElement
    extends AutoDisposeFutureProviderElement<RecipeDetailsModel>
    with GetRecipeDetailsRef {
  _GetRecipeDetailsProviderElement(super.provider);

  @override
  String get recipeId => (origin as GetRecipeDetailsProvider).recipeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
