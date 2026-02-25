// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_basket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createShoppingBasketHash() =>
    r'c72a75c917b07aa73b75eda6a315e03f48a69639';

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

/// --- 🛒 CREATE SHOPPING BASKET ---
///
/// Copied from [createShoppingBasket].
@ProviderFor(createShoppingBasket)
const createShoppingBasketProvider = CreateShoppingBasketFamily();

/// --- 🛒 CREATE SHOPPING BASKET ---
///
/// Copied from [createShoppingBasket].
class CreateShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- 🛒 CREATE SHOPPING BASKET ---
  ///
  /// Copied from [createShoppingBasket].
  const CreateShoppingBasketFamily();

  /// --- 🛒 CREATE SHOPPING BASKET ---
  ///
  /// Copied from [createShoppingBasket].
  CreateShoppingBasketProvider call(
    String basketName,
  ) {
    return CreateShoppingBasketProvider(
      basketName,
    );
  }

  @override
  CreateShoppingBasketProvider getProviderOverride(
    covariant CreateShoppingBasketProvider provider,
  ) {
    return call(
      provider.basketName,
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
  String? get name => r'createShoppingBasketProvider';
}

/// --- 🛒 CREATE SHOPPING BASKET ---
///
/// Copied from [createShoppingBasket].
class CreateShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🛒 CREATE SHOPPING BASKET ---
  ///
  /// Copied from [createShoppingBasket].
  CreateShoppingBasketProvider(
    String basketName,
  ) : this._internal(
          (ref) => createShoppingBasket(
            ref as CreateShoppingBasketRef,
            basketName,
          ),
          from: createShoppingBasketProvider,
          name: r'createShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createShoppingBasketHash,
          dependencies: CreateShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              CreateShoppingBasketFamily._allTransitiveDependencies,
          basketName: basketName,
        );

  CreateShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketName,
  }) : super.internal();

  final String basketName;

  @override
  Override overrideWith(
    FutureOr<void> Function(CreateShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateShoppingBasketProvider._internal(
        (ref) => create(ref as CreateShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketName: basketName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CreateShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateShoppingBasketProvider &&
        other.basketName == basketName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketName` of this provider.
  String get basketName;
}

class _CreateShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CreateShoppingBasketRef {
  _CreateShoppingBasketProviderElement(super.provider);

  @override
  String get basketName => (origin as CreateShoppingBasketProvider).basketName;
}

String _$getShoppingBasketHash() => r'6c00fa7d46f3efce04c548e98f728aaf3f6b9ed4';

/// --- 📦 GET SINGLE BASKET BY ID ---
///
/// Copied from [getShoppingBasket].
@ProviderFor(getShoppingBasket)
const getShoppingBasketProvider = GetShoppingBasketFamily();

/// --- 📦 GET SINGLE BASKET BY ID ---
///
/// Copied from [getShoppingBasket].
class GetShoppingBasketFamily
    extends Family<AsyncValue<GetShoppingBasketResponse>> {
  /// --- 📦 GET SINGLE BASKET BY ID ---
  ///
  /// Copied from [getShoppingBasket].
  const GetShoppingBasketFamily();

  /// --- 📦 GET SINGLE BASKET BY ID ---
  ///
  /// Copied from [getShoppingBasket].
  GetShoppingBasketProvider call({
    required String basketId,
  }) {
    return GetShoppingBasketProvider(
      basketId: basketId,
    );
  }

  @override
  GetShoppingBasketProvider getProviderOverride(
    covariant GetShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'getShoppingBasketProvider';
}

/// --- 📦 GET SINGLE BASKET BY ID ---
///
/// Copied from [getShoppingBasket].
class GetShoppingBasketProvider
    extends AutoDisposeFutureProvider<GetShoppingBasketResponse> {
  /// --- 📦 GET SINGLE BASKET BY ID ---
  ///
  /// Copied from [getShoppingBasket].
  GetShoppingBasketProvider({
    required String basketId,
  }) : this._internal(
          (ref) => getShoppingBasket(
            ref as GetShoppingBasketRef,
            basketId: basketId,
          ),
          from: getShoppingBasketProvider,
          name: r'getShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getShoppingBasketHash,
          dependencies: GetShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              GetShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  GetShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<GetShoppingBasketResponse> Function(GetShoppingBasketRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetShoppingBasketProvider._internal(
        (ref) => create(ref as GetShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GetShoppingBasketResponse> createElement() {
    return _GetShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetShoppingBasketProvider && other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetShoppingBasketRef
    on AutoDisposeFutureProviderRef<GetShoppingBasketResponse> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _GetShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<GetShoppingBasketResponse>
    with GetShoppingBasketRef {
  _GetShoppingBasketProviderElement(super.provider);

  @override
  String get basketId => (origin as GetShoppingBasketProvider).basketId;
}

String _$getUserOpenShoppingBasketsHash() =>
    r'df9697e885ca4bfeda73ee04d5c06063b151f4cd';

/// --- 📂 GET OPEN SHOPPING BASKETS ---
///
/// Copied from [getUserOpenShoppingBaskets].
@ProviderFor(getUserOpenShoppingBaskets)
final getUserOpenShoppingBasketsProvider =
    AutoDisposeFutureProvider<List<GetShoppingBasketResponse>>.internal(
  getUserOpenShoppingBaskets,
  name: r'getUserOpenShoppingBasketsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserOpenShoppingBasketsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserOpenShoppingBasketsRef
    = AutoDisposeFutureProviderRef<List<GetShoppingBasketResponse>>;
String _$getUserClosedShoppingBasketsHash() =>
    r'6fc8b8eda0ba4854f8ceefa46173c1a57a043379';

/// --- 📁 GET CLOSED SHOPPING BASKETS ---
///
/// Copied from [getUserClosedShoppingBaskets].
@ProviderFor(getUserClosedShoppingBaskets)
final getUserClosedShoppingBasketsProvider =
    AutoDisposeFutureProvider<List<GetShoppingBasketResponse>>.internal(
  getUserClosedShoppingBaskets,
  name: r'getUserClosedShoppingBasketsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserClosedShoppingBasketsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserClosedShoppingBasketsRef
    = AutoDisposeFutureProviderRef<List<GetShoppingBasketResponse>>;
String _$deleteShoppingBasketHash() =>
    r'6d0fc8551c248dabe5f6a9e65a70dd3bc64a1ace';

/// --- 🗑️ DELETE SHOPPING BASKET ---
///
/// Copied from [deleteShoppingBasket].
@ProviderFor(deleteShoppingBasket)
const deleteShoppingBasketProvider = DeleteShoppingBasketFamily();

/// --- 🗑️ DELETE SHOPPING BASKET ---
///
/// Copied from [deleteShoppingBasket].
class DeleteShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- 🗑️ DELETE SHOPPING BASKET ---
  ///
  /// Copied from [deleteShoppingBasket].
  const DeleteShoppingBasketFamily();

  /// --- 🗑️ DELETE SHOPPING BASKET ---
  ///
  /// Copied from [deleteShoppingBasket].
  DeleteShoppingBasketProvider call({
    required String basketId,
  }) {
    return DeleteShoppingBasketProvider(
      basketId: basketId,
    );
  }

  @override
  DeleteShoppingBasketProvider getProviderOverride(
    covariant DeleteShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'deleteShoppingBasketProvider';
}

/// --- 🗑️ DELETE SHOPPING BASKET ---
///
/// Copied from [deleteShoppingBasket].
class DeleteShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🗑️ DELETE SHOPPING BASKET ---
  ///
  /// Copied from [deleteShoppingBasket].
  DeleteShoppingBasketProvider({
    required String basketId,
  }) : this._internal(
          (ref) => deleteShoppingBasket(
            ref as DeleteShoppingBasketRef,
            basketId: basketId,
          ),
          from: deleteShoppingBasketProvider,
          name: r'deleteShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteShoppingBasketHash,
          dependencies: DeleteShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              DeleteShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  DeleteShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteShoppingBasketProvider._internal(
        (ref) => create(ref as DeleteShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteShoppingBasketProvider && other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _DeleteShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteShoppingBasketRef {
  _DeleteShoppingBasketProviderElement(super.provider);

  @override
  String get basketId => (origin as DeleteShoppingBasketProvider).basketId;
}

String _$updateShoppingBasketHash() =>
    r'ac4d20d99c9483f365d0e879baaaeb14e23ffb36';

/// --- ✏️ UPDATE SHOPPING BASKET NAME ---
///
/// Copied from [updateShoppingBasket].
@ProviderFor(updateShoppingBasket)
const updateShoppingBasketProvider = UpdateShoppingBasketFamily();

/// --- ✏️ UPDATE SHOPPING BASKET NAME ---
///
/// Copied from [updateShoppingBasket].
class UpdateShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- ✏️ UPDATE SHOPPING BASKET NAME ---
  ///
  /// Copied from [updateShoppingBasket].
  const UpdateShoppingBasketFamily();

  /// --- ✏️ UPDATE SHOPPING BASKET NAME ---
  ///
  /// Copied from [updateShoppingBasket].
  UpdateShoppingBasketProvider call({
    required String basketId,
    required String basketName,
  }) {
    return UpdateShoppingBasketProvider(
      basketId: basketId,
      basketName: basketName,
    );
  }

  @override
  UpdateShoppingBasketProvider getProviderOverride(
    covariant UpdateShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
      basketName: provider.basketName,
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
  String? get name => r'updateShoppingBasketProvider';
}

/// --- ✏️ UPDATE SHOPPING BASKET NAME ---
///
/// Copied from [updateShoppingBasket].
class UpdateShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- ✏️ UPDATE SHOPPING BASKET NAME ---
  ///
  /// Copied from [updateShoppingBasket].
  UpdateShoppingBasketProvider({
    required String basketId,
    required String basketName,
  }) : this._internal(
          (ref) => updateShoppingBasket(
            ref as UpdateShoppingBasketRef,
            basketId: basketId,
            basketName: basketName,
          ),
          from: updateShoppingBasketProvider,
          name: r'updateShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateShoppingBasketHash,
          dependencies: UpdateShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              UpdateShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
          basketName: basketName,
        );

  UpdateShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
    required this.basketName,
  }) : super.internal();

  final String basketId;
  final String basketName;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateShoppingBasketProvider._internal(
        (ref) => create(ref as UpdateShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
        basketName: basketName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateShoppingBasketProvider &&
        other.basketId == basketId &&
        other.basketName == basketName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);
    hash = _SystemHash.combine(hash, basketName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketId` of this provider.
  String get basketId;

  /// The parameter `basketName` of this provider.
  String get basketName;
}

class _UpdateShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateShoppingBasketRef {
  _UpdateShoppingBasketProviderElement(super.provider);

  @override
  String get basketId => (origin as UpdateShoppingBasketProvider).basketId;
  @override
  String get basketName => (origin as UpdateShoppingBasketProvider).basketName;
}

String _$getShoppingBasketByUniqueStringHash() =>
    r'37f8e879a5eca43afceeb7232c30d9fff40e3749';

/// --- 🔗 GET BASKET BY UNIQUE STRING ---
///
/// Copied from [getShoppingBasketByUniqueString].
@ProviderFor(getShoppingBasketByUniqueString)
const getShoppingBasketByUniqueStringProvider =
    GetShoppingBasketByUniqueStringFamily();

/// --- 🔗 GET BASKET BY UNIQUE STRING ---
///
/// Copied from [getShoppingBasketByUniqueString].
class GetShoppingBasketByUniqueStringFamily
    extends Family<AsyncValue<GetShoppingBasketByUniqueStringResponse>> {
  /// --- 🔗 GET BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [getShoppingBasketByUniqueString].
  const GetShoppingBasketByUniqueStringFamily();

  /// --- 🔗 GET BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [getShoppingBasketByUniqueString].
  GetShoppingBasketByUniqueStringProvider call({
    required String uniqueString,
  }) {
    return GetShoppingBasketByUniqueStringProvider(
      uniqueString: uniqueString,
    );
  }

  @override
  GetShoppingBasketByUniqueStringProvider getProviderOverride(
    covariant GetShoppingBasketByUniqueStringProvider provider,
  ) {
    return call(
      uniqueString: provider.uniqueString,
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
  String? get name => r'getShoppingBasketByUniqueStringProvider';
}

/// --- 🔗 GET BASKET BY UNIQUE STRING ---
///
/// Copied from [getShoppingBasketByUniqueString].
class GetShoppingBasketByUniqueStringProvider
    extends AutoDisposeFutureProvider<GetShoppingBasketByUniqueStringResponse> {
  /// --- 🔗 GET BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [getShoppingBasketByUniqueString].
  GetShoppingBasketByUniqueStringProvider({
    required String uniqueString,
  }) : this._internal(
          (ref) => getShoppingBasketByUniqueString(
            ref as GetShoppingBasketByUniqueStringRef,
            uniqueString: uniqueString,
          ),
          from: getShoppingBasketByUniqueStringProvider,
          name: r'getShoppingBasketByUniqueStringProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getShoppingBasketByUniqueStringHash,
          dependencies: GetShoppingBasketByUniqueStringFamily._dependencies,
          allTransitiveDependencies:
              GetShoppingBasketByUniqueStringFamily._allTransitiveDependencies,
          uniqueString: uniqueString,
        );

  GetShoppingBasketByUniqueStringProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uniqueString,
  }) : super.internal();

  final String uniqueString;

  @override
  Override overrideWith(
    FutureOr<GetShoppingBasketByUniqueStringResponse> Function(
            GetShoppingBasketByUniqueStringRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetShoppingBasketByUniqueStringProvider._internal(
        (ref) => create(ref as GetShoppingBasketByUniqueStringRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uniqueString: uniqueString,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GetShoppingBasketByUniqueStringResponse>
      createElement() {
    return _GetShoppingBasketByUniqueStringProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetShoppingBasketByUniqueStringProvider &&
        other.uniqueString == uniqueString;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uniqueString.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetShoppingBasketByUniqueStringRef
    on AutoDisposeFutureProviderRef<GetShoppingBasketByUniqueStringResponse> {
  /// The parameter `uniqueString` of this provider.
  String get uniqueString;
}

class _GetShoppingBasketByUniqueStringProviderElement
    extends AutoDisposeFutureProviderElement<
        GetShoppingBasketByUniqueStringResponse>
    with GetShoppingBasketByUniqueStringRef {
  _GetShoppingBasketByUniqueStringProviderElement(super.provider);

  @override
  String get uniqueString =>
      (origin as GetShoppingBasketByUniqueStringProvider).uniqueString;
}

String _$closeShoppingBasketHash() =>
    r'bbc20c763dc7517cde93ce9c5d1a89691729a47c';

/// --- 🚪 CLOSE SHOPPING BASKET ---
///
/// Copied from [closeShoppingBasket].
@ProviderFor(closeShoppingBasket)
const closeShoppingBasketProvider = CloseShoppingBasketFamily();

/// --- 🚪 CLOSE SHOPPING BASKET ---
///
/// Copied from [closeShoppingBasket].
class CloseShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- 🚪 CLOSE SHOPPING BASKET ---
  ///
  /// Copied from [closeShoppingBasket].
  const CloseShoppingBasketFamily();

  /// --- 🚪 CLOSE SHOPPING BASKET ---
  ///
  /// Copied from [closeShoppingBasket].
  CloseShoppingBasketProvider call({
    required String basketId,
  }) {
    return CloseShoppingBasketProvider(
      basketId: basketId,
    );
  }

  @override
  CloseShoppingBasketProvider getProviderOverride(
    covariant CloseShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'closeShoppingBasketProvider';
}

/// --- 🚪 CLOSE SHOPPING BASKET ---
///
/// Copied from [closeShoppingBasket].
class CloseShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🚪 CLOSE SHOPPING BASKET ---
  ///
  /// Copied from [closeShoppingBasket].
  CloseShoppingBasketProvider({
    required String basketId,
  }) : this._internal(
          (ref) => closeShoppingBasket(
            ref as CloseShoppingBasketRef,
            basketId: basketId,
          ),
          from: closeShoppingBasketProvider,
          name: r'closeShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$closeShoppingBasketHash,
          dependencies: CloseShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              CloseShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  CloseShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<void> Function(CloseShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CloseShoppingBasketProvider._internal(
        (ref) => create(ref as CloseShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CloseShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CloseShoppingBasketProvider && other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CloseShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _CloseShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void> with CloseShoppingBasketRef {
  _CloseShoppingBasketProviderElement(super.provider);

  @override
  String get basketId => (origin as CloseShoppingBasketProvider).basketId;
}

String _$addItemToShoppingBasketHash() =>
    r'c7783af0d284fc8754fd08574e6b7bd0a1ba1f86';

/// --- ➕ ADD ITEM TO SHOPPING BASKET ---
///
/// Copied from [addItemToShoppingBasket].
@ProviderFor(addItemToShoppingBasket)
const addItemToShoppingBasketProvider = AddItemToShoppingBasketFamily();

/// --- ➕ ADD ITEM TO SHOPPING BASKET ---
///
/// Copied from [addItemToShoppingBasket].
class AddItemToShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- ➕ ADD ITEM TO SHOPPING BASKET ---
  ///
  /// Copied from [addItemToShoppingBasket].
  const AddItemToShoppingBasketFamily();

  /// --- ➕ ADD ITEM TO SHOPPING BASKET ---
  ///
  /// Copied from [addItemToShoppingBasket].
  AddItemToShoppingBasketProvider call({
    required AddItemToShoppingBasket request,
  }) {
    return AddItemToShoppingBasketProvider(
      request: request,
    );
  }

  @override
  AddItemToShoppingBasketProvider getProviderOverride(
    covariant AddItemToShoppingBasketProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'addItemToShoppingBasketProvider';
}

/// --- ➕ ADD ITEM TO SHOPPING BASKET ---
///
/// Copied from [addItemToShoppingBasket].
class AddItemToShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- ➕ ADD ITEM TO SHOPPING BASKET ---
  ///
  /// Copied from [addItemToShoppingBasket].
  AddItemToShoppingBasketProvider({
    required AddItemToShoppingBasket request,
  }) : this._internal(
          (ref) => addItemToShoppingBasket(
            ref as AddItemToShoppingBasketRef,
            request: request,
          ),
          from: addItemToShoppingBasketProvider,
          name: r'addItemToShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addItemToShoppingBasketHash,
          dependencies: AddItemToShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              AddItemToShoppingBasketFamily._allTransitiveDependencies,
          request: request,
        );

  AddItemToShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final AddItemToShoppingBasket request;

  @override
  Override overrideWith(
    FutureOr<void> Function(AddItemToShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddItemToShoppingBasketProvider._internal(
        (ref) => create(ref as AddItemToShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddItemToShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddItemToShoppingBasketProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddItemToShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  AddItemToShoppingBasket get request;
}

class _AddItemToShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with AddItemToShoppingBasketRef {
  _AddItemToShoppingBasketProviderElement(super.provider);

  @override
  AddItemToShoppingBasket get request =>
      (origin as AddItemToShoppingBasketProvider).request;
}

String _$getShoppingBasketItemHash() =>
    r'921758e165a29fde773d6a737752ada21d4ede77';

/// --- 🧾 GET SHOPPING BASKET ITEM ---
///
/// Copied from [getShoppingBasketItem].
@ProviderFor(getShoppingBasketItem)
const getShoppingBasketItemProvider = GetShoppingBasketItemFamily();

/// --- 🧾 GET SHOPPING BASKET ITEM ---
///
/// Copied from [getShoppingBasketItem].
class GetShoppingBasketItemFamily
    extends Family<AsyncValue<GetShoppingBasketItemResponse>> {
  /// --- 🧾 GET SHOPPING BASKET ITEM ---
  ///
  /// Copied from [getShoppingBasketItem].
  const GetShoppingBasketItemFamily();

  /// --- 🧾 GET SHOPPING BASKET ITEM ---
  ///
  /// Copied from [getShoppingBasketItem].
  GetShoppingBasketItemProvider call({
    required String itemId,
  }) {
    return GetShoppingBasketItemProvider(
      itemId: itemId,
    );
  }

  @override
  GetShoppingBasketItemProvider getProviderOverride(
    covariant GetShoppingBasketItemProvider provider,
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
  String? get name => r'getShoppingBasketItemProvider';
}

/// --- 🧾 GET SHOPPING BASKET ITEM ---
///
/// Copied from [getShoppingBasketItem].
class GetShoppingBasketItemProvider
    extends AutoDisposeFutureProvider<GetShoppingBasketItemResponse> {
  /// --- 🧾 GET SHOPPING BASKET ITEM ---
  ///
  /// Copied from [getShoppingBasketItem].
  GetShoppingBasketItemProvider({
    required String itemId,
  }) : this._internal(
          (ref) => getShoppingBasketItem(
            ref as GetShoppingBasketItemRef,
            itemId: itemId,
          ),
          from: getShoppingBasketItemProvider,
          name: r'getShoppingBasketItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getShoppingBasketItemHash,
          dependencies: GetShoppingBasketItemFamily._dependencies,
          allTransitiveDependencies:
              GetShoppingBasketItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  GetShoppingBasketItemProvider._internal(
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
    FutureOr<GetShoppingBasketItemResponse> Function(
            GetShoppingBasketItemRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetShoppingBasketItemProvider._internal(
        (ref) => create(ref as GetShoppingBasketItemRef),
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
  AutoDisposeFutureProviderElement<GetShoppingBasketItemResponse>
      createElement() {
    return _GetShoppingBasketItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetShoppingBasketItemProvider && other.itemId == itemId;
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
mixin GetShoppingBasketItemRef
    on AutoDisposeFutureProviderRef<GetShoppingBasketItemResponse> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _GetShoppingBasketItemProviderElement
    extends AutoDisposeFutureProviderElement<GetShoppingBasketItemResponse>
    with GetShoppingBasketItemRef {
  _GetShoppingBasketItemProviderElement(super.provider);

  @override
  String get itemId => (origin as GetShoppingBasketItemProvider).itemId;
}

String _$checkoutShoppingBasketItemsHash() =>
    r'f05ae03ced16238dccdc18de3a1ceb3190499c93';

/// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
///
/// Copied from [checkoutShoppingBasketItems].
@ProviderFor(checkoutShoppingBasketItems)
const checkoutShoppingBasketItemsProvider = CheckoutShoppingBasketItemsFamily();

/// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
///
/// Copied from [checkoutShoppingBasketItems].
class CheckoutShoppingBasketItemsFamily extends Family<AsyncValue<void>> {
  /// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [checkoutShoppingBasketItems].
  const CheckoutShoppingBasketItemsFamily();

  /// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [checkoutShoppingBasketItems].
  CheckoutShoppingBasketItemsProvider call({
    required CheckoutShoppingBasketItemsRequest request,
  }) {
    return CheckoutShoppingBasketItemsProvider(
      request: request,
    );
  }

  @override
  CheckoutShoppingBasketItemsProvider getProviderOverride(
    covariant CheckoutShoppingBasketItemsProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'checkoutShoppingBasketItemsProvider';
}

/// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
///
/// Copied from [checkoutShoppingBasketItems].
class CheckoutShoppingBasketItemsProvider
    extends AutoDisposeFutureProvider<void> {
  /// --- ✅ CHECKOUT SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [checkoutShoppingBasketItems].
  CheckoutShoppingBasketItemsProvider({
    required CheckoutShoppingBasketItemsRequest request,
  }) : this._internal(
          (ref) => checkoutShoppingBasketItems(
            ref as CheckoutShoppingBasketItemsRef,
            request: request,
          ),
          from: checkoutShoppingBasketItemsProvider,
          name: r'checkoutShoppingBasketItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkoutShoppingBasketItemsHash,
          dependencies: CheckoutShoppingBasketItemsFamily._dependencies,
          allTransitiveDependencies:
              CheckoutShoppingBasketItemsFamily._allTransitiveDependencies,
          request: request,
        );

  CheckoutShoppingBasketItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final CheckoutShoppingBasketItemsRequest request;

  @override
  Override overrideWith(
    FutureOr<void> Function(CheckoutShoppingBasketItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckoutShoppingBasketItemsProvider._internal(
        (ref) => create(ref as CheckoutShoppingBasketItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CheckoutShoppingBasketItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckoutShoppingBasketItemsProvider &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckoutShoppingBasketItemsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  CheckoutShoppingBasketItemsRequest get request;
}

class _CheckoutShoppingBasketItemsProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CheckoutShoppingBasketItemsRef {
  _CheckoutShoppingBasketItemsProviderElement(super.provider);

  @override
  CheckoutShoppingBasketItemsRequest get request =>
      (origin as CheckoutShoppingBasketItemsProvider).request;
}

String _$deleteShoppingBasketItemHash() =>
    r'fb2cf684fadaa55ba8555a8839cbe5758d34a62a';

/// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
///
/// Copied from [deleteShoppingBasketItem].
@ProviderFor(deleteShoppingBasketItem)
const deleteShoppingBasketItemProvider = DeleteShoppingBasketItemFamily();

/// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
///
/// Copied from [deleteShoppingBasketItem].
class DeleteShoppingBasketItemFamily extends Family<AsyncValue<void>> {
  /// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [deleteShoppingBasketItem].
  const DeleteShoppingBasketItemFamily();

  /// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [deleteShoppingBasketItem].
  DeleteShoppingBasketItemProvider call({
    required String itemId,
  }) {
    return DeleteShoppingBasketItemProvider(
      itemId: itemId,
    );
  }

  @override
  DeleteShoppingBasketItemProvider getProviderOverride(
    covariant DeleteShoppingBasketItemProvider provider,
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
  String? get name => r'deleteShoppingBasketItemProvider';
}

/// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
///
/// Copied from [deleteShoppingBasketItem].
class DeleteShoppingBasketItemProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🗑️ DELETE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [deleteShoppingBasketItem].
  DeleteShoppingBasketItemProvider({
    required String itemId,
  }) : this._internal(
          (ref) => deleteShoppingBasketItem(
            ref as DeleteShoppingBasketItemRef,
            itemId: itemId,
          ),
          from: deleteShoppingBasketItemProvider,
          name: r'deleteShoppingBasketItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteShoppingBasketItemHash,
          dependencies: DeleteShoppingBasketItemFamily._dependencies,
          allTransitiveDependencies:
              DeleteShoppingBasketItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  DeleteShoppingBasketItemProvider._internal(
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
    FutureOr<void> Function(DeleteShoppingBasketItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteShoppingBasketItemProvider._internal(
        (ref) => create(ref as DeleteShoppingBasketItemRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteShoppingBasketItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteShoppingBasketItemProvider && other.itemId == itemId;
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
mixin DeleteShoppingBasketItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _DeleteShoppingBasketItemProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteShoppingBasketItemRef {
  _DeleteShoppingBasketItemProviderElement(super.provider);

  @override
  String get itemId => (origin as DeleteShoppingBasketItemProvider).itemId;
}

String _$updateShoppingBasketItemHash() =>
    r'7931a14f875ca2968ab355de4b29037582b91405';

/// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
///
/// Copied from [updateShoppingBasketItem].
@ProviderFor(updateShoppingBasketItem)
const updateShoppingBasketItemProvider = UpdateShoppingBasketItemFamily();

/// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
///
/// Copied from [updateShoppingBasketItem].
class UpdateShoppingBasketItemFamily extends Family<AsyncValue<void>> {
  /// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [updateShoppingBasketItem].
  const UpdateShoppingBasketItemFamily();

  /// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [updateShoppingBasketItem].
  UpdateShoppingBasketItemProvider call({
    required UpdateShoppingBasketItemRequest request,
  }) {
    return UpdateShoppingBasketItemProvider(
      request: request,
    );
  }

  @override
  UpdateShoppingBasketItemProvider getProviderOverride(
    covariant UpdateShoppingBasketItemProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'updateShoppingBasketItemProvider';
}

/// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
///
/// Copied from [updateShoppingBasketItem].
class UpdateShoppingBasketItemProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🔄 UPDATE SHOPPING BASKET ITEM ---
  ///
  /// Copied from [updateShoppingBasketItem].
  UpdateShoppingBasketItemProvider({
    required UpdateShoppingBasketItemRequest request,
  }) : this._internal(
          (ref) => updateShoppingBasketItem(
            ref as UpdateShoppingBasketItemRef,
            request: request,
          ),
          from: updateShoppingBasketItemProvider,
          name: r'updateShoppingBasketItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateShoppingBasketItemHash,
          dependencies: UpdateShoppingBasketItemFamily._dependencies,
          allTransitiveDependencies:
              UpdateShoppingBasketItemFamily._allTransitiveDependencies,
          request: request,
        );

  UpdateShoppingBasketItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final UpdateShoppingBasketItemRequest request;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateShoppingBasketItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateShoppingBasketItemProvider._internal(
        (ref) => create(ref as UpdateShoppingBasketItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateShoppingBasketItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateShoppingBasketItemProvider &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateShoppingBasketItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  UpdateShoppingBasketItemRequest get request;
}

class _UpdateShoppingBasketItemProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateShoppingBasketItemRef {
  _UpdateShoppingBasketItemProviderElement(super.provider);

  @override
  UpdateShoppingBasketItemRequest get request =>
      (origin as UpdateShoppingBasketItemProvider).request;
}

String _$getShoppingBasketUsersHash() =>
    r'4f7d87a360eec7112dda40ae4992d69b934f7d2b';

/// --- 👥 GET SHOPPING BASKET USERS ---
///
/// Copied from [getShoppingBasketUsers].
@ProviderFor(getShoppingBasketUsers)
const getShoppingBasketUsersProvider = GetShoppingBasketUsersFamily();

/// --- 👥 GET SHOPPING BASKET USERS ---
///
/// Copied from [getShoppingBasketUsers].
class GetShoppingBasketUsersFamily
    extends Family<AsyncValue<List<GetShoppingBasketUsersResponse>>> {
  /// --- 👥 GET SHOPPING BASKET USERS ---
  ///
  /// Copied from [getShoppingBasketUsers].
  const GetShoppingBasketUsersFamily();

  /// --- 👥 GET SHOPPING BASKET USERS ---
  ///
  /// Copied from [getShoppingBasketUsers].
  GetShoppingBasketUsersProvider call({
    required String basketId,
  }) {
    return GetShoppingBasketUsersProvider(
      basketId: basketId,
    );
  }

  @override
  GetShoppingBasketUsersProvider getProviderOverride(
    covariant GetShoppingBasketUsersProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'getShoppingBasketUsersProvider';
}

/// --- 👥 GET SHOPPING BASKET USERS ---
///
/// Copied from [getShoppingBasketUsers].
class GetShoppingBasketUsersProvider
    extends AutoDisposeFutureProvider<List<GetShoppingBasketUsersResponse>> {
  /// --- 👥 GET SHOPPING BASKET USERS ---
  ///
  /// Copied from [getShoppingBasketUsers].
  GetShoppingBasketUsersProvider({
    required String basketId,
  }) : this._internal(
          (ref) => getShoppingBasketUsers(
            ref as GetShoppingBasketUsersRef,
            basketId: basketId,
          ),
          from: getShoppingBasketUsersProvider,
          name: r'getShoppingBasketUsersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getShoppingBasketUsersHash,
          dependencies: GetShoppingBasketUsersFamily._dependencies,
          allTransitiveDependencies:
              GetShoppingBasketUsersFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  GetShoppingBasketUsersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<List<GetShoppingBasketUsersResponse>> Function(
            GetShoppingBasketUsersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetShoppingBasketUsersProvider._internal(
        (ref) => create(ref as GetShoppingBasketUsersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<GetShoppingBasketUsersResponse>>
      createElement() {
    return _GetShoppingBasketUsersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetShoppingBasketUsersProvider &&
        other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetShoppingBasketUsersRef
    on AutoDisposeFutureProviderRef<List<GetShoppingBasketUsersResponse>> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _GetShoppingBasketUsersProviderElement
    extends AutoDisposeFutureProviderElement<
        List<GetShoppingBasketUsersResponse>> with GetShoppingBasketUsersRef {
  _GetShoppingBasketUsersProviderElement(super.provider);

  @override
  String get basketId => (origin as GetShoppingBasketUsersProvider).basketId;
}

String _$removeUserFromShoppingBasketHash() =>
    r'1c0344a9aec7096e430d22b55d72e6325c9be8a7';

/// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
///
/// Copied from [removeUserFromShoppingBasket].
@ProviderFor(removeUserFromShoppingBasket)
const removeUserFromShoppingBasketProvider =
    RemoveUserFromShoppingBasketFamily();

/// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
///
/// Copied from [removeUserFromShoppingBasket].
class RemoveUserFromShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
  ///
  /// Copied from [removeUserFromShoppingBasket].
  const RemoveUserFromShoppingBasketFamily();

  /// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
  ///
  /// Copied from [removeUserFromShoppingBasket].
  RemoveUserFromShoppingBasketProvider call({
    required String basketId,
    required String userId,
  }) {
    return RemoveUserFromShoppingBasketProvider(
      basketId: basketId,
      userId: userId,
    );
  }

  @override
  RemoveUserFromShoppingBasketProvider getProviderOverride(
    covariant RemoveUserFromShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
      userId: provider.userId,
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
  String? get name => r'removeUserFromShoppingBasketProvider';
}

/// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
///
/// Copied from [removeUserFromShoppingBasket].
class RemoveUserFromShoppingBasketProvider
    extends AutoDisposeFutureProvider<void> {
  /// --- 🚫 REMOVE USER FROM SHOPPING BASKET ---
  ///
  /// Copied from [removeUserFromShoppingBasket].
  RemoveUserFromShoppingBasketProvider({
    required String basketId,
    required String userId,
  }) : this._internal(
          (ref) => removeUserFromShoppingBasket(
            ref as RemoveUserFromShoppingBasketRef,
            basketId: basketId,
            userId: userId,
          ),
          from: removeUserFromShoppingBasketProvider,
          name: r'removeUserFromShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeUserFromShoppingBasketHash,
          dependencies: RemoveUserFromShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              RemoveUserFromShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
          userId: userId,
        );

  RemoveUserFromShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
    required this.userId,
  }) : super.internal();

  final String basketId;
  final String userId;

  @override
  Override overrideWith(
    FutureOr<void> Function(RemoveUserFromShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveUserFromShoppingBasketProvider._internal(
        (ref) => create(ref as RemoveUserFromShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemoveUserFromShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveUserFromShoppingBasketProvider &&
        other.basketId == basketId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveUserFromShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketId` of this provider.
  String get basketId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _RemoveUserFromShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with RemoveUserFromShoppingBasketRef {
  _RemoveUserFromShoppingBasketProviderElement(super.provider);

  @override
  String get basketId =>
      (origin as RemoveUserFromShoppingBasketProvider).basketId;
  @override
  String get userId => (origin as RemoveUserFromShoppingBasketProvider).userId;
}

String _$joinShoppingBasketByUniqueStringHash() =>
    r'078ed79a6c1c8a0e3f48664ae7de666e0c0661fc';

/// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
///
/// Copied from [joinShoppingBasketByUniqueString].
@ProviderFor(joinShoppingBasketByUniqueString)
const joinShoppingBasketByUniqueStringProvider =
    JoinShoppingBasketByUniqueStringFamily();

/// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
///
/// Copied from [joinShoppingBasketByUniqueString].
class JoinShoppingBasketByUniqueStringFamily extends Family<AsyncValue<void>> {
  /// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [joinShoppingBasketByUniqueString].
  const JoinShoppingBasketByUniqueStringFamily();

  /// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [joinShoppingBasketByUniqueString].
  JoinShoppingBasketByUniqueStringProvider call({
    required String uniqueString,
  }) {
    return JoinShoppingBasketByUniqueStringProvider(
      uniqueString: uniqueString,
    );
  }

  @override
  JoinShoppingBasketByUniqueStringProvider getProviderOverride(
    covariant JoinShoppingBasketByUniqueStringProvider provider,
  ) {
    return call(
      uniqueString: provider.uniqueString,
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
  String? get name => r'joinShoppingBasketByUniqueStringProvider';
}

/// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
///
/// Copied from [joinShoppingBasketByUniqueString].
class JoinShoppingBasketByUniqueStringProvider
    extends AutoDisposeFutureProvider<void> {
  /// --- 🔑 JOIN SHOPPING BASKET BY UNIQUE STRING ---
  ///
  /// Copied from [joinShoppingBasketByUniqueString].
  JoinShoppingBasketByUniqueStringProvider({
    required String uniqueString,
  }) : this._internal(
          (ref) => joinShoppingBasketByUniqueString(
            ref as JoinShoppingBasketByUniqueStringRef,
            uniqueString: uniqueString,
          ),
          from: joinShoppingBasketByUniqueStringProvider,
          name: r'joinShoppingBasketByUniqueStringProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$joinShoppingBasketByUniqueStringHash,
          dependencies: JoinShoppingBasketByUniqueStringFamily._dependencies,
          allTransitiveDependencies:
              JoinShoppingBasketByUniqueStringFamily._allTransitiveDependencies,
          uniqueString: uniqueString,
        );

  JoinShoppingBasketByUniqueStringProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uniqueString,
  }) : super.internal();

  final String uniqueString;

  @override
  Override overrideWith(
    FutureOr<void> Function(JoinShoppingBasketByUniqueStringRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JoinShoppingBasketByUniqueStringProvider._internal(
        (ref) => create(ref as JoinShoppingBasketByUniqueStringRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uniqueString: uniqueString,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _JoinShoppingBasketByUniqueStringProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JoinShoppingBasketByUniqueStringProvider &&
        other.uniqueString == uniqueString;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uniqueString.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JoinShoppingBasketByUniqueStringRef
    on AutoDisposeFutureProviderRef<void> {
  /// The parameter `uniqueString` of this provider.
  String get uniqueString;
}

class _JoinShoppingBasketByUniqueStringProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with JoinShoppingBasketByUniqueStringRef {
  _JoinShoppingBasketByUniqueStringProviderElement(super.provider);

  @override
  String get uniqueString =>
      (origin as JoinShoppingBasketByUniqueStringProvider).uniqueString;
}

String _$leaveShoppingBasketHash() =>
    r'e50040c752660a361cfb7c38dcab88a14bc6c391';

/// --- 🚪 LEAVE SHOPPING BASKET ---
///
/// Copied from [leaveShoppingBasket].
@ProviderFor(leaveShoppingBasket)
const leaveShoppingBasketProvider = LeaveShoppingBasketFamily();

/// --- 🚪 LEAVE SHOPPING BASKET ---
///
/// Copied from [leaveShoppingBasket].
class LeaveShoppingBasketFamily extends Family<AsyncValue<void>> {
  /// --- 🚪 LEAVE SHOPPING BASKET ---
  ///
  /// Copied from [leaveShoppingBasket].
  const LeaveShoppingBasketFamily();

  /// --- 🚪 LEAVE SHOPPING BASKET ---
  ///
  /// Copied from [leaveShoppingBasket].
  LeaveShoppingBasketProvider call({
    required String basketId,
  }) {
    return LeaveShoppingBasketProvider(
      basketId: basketId,
    );
  }

  @override
  LeaveShoppingBasketProvider getProviderOverride(
    covariant LeaveShoppingBasketProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'leaveShoppingBasketProvider';
}

/// --- 🚪 LEAVE SHOPPING BASKET ---
///
/// Copied from [leaveShoppingBasket].
class LeaveShoppingBasketProvider extends AutoDisposeFutureProvider<void> {
  /// --- 🚪 LEAVE SHOPPING BASKET ---
  ///
  /// Copied from [leaveShoppingBasket].
  LeaveShoppingBasketProvider({
    required String basketId,
  }) : this._internal(
          (ref) => leaveShoppingBasket(
            ref as LeaveShoppingBasketRef,
            basketId: basketId,
          ),
          from: leaveShoppingBasketProvider,
          name: r'leaveShoppingBasketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveShoppingBasketHash,
          dependencies: LeaveShoppingBasketFamily._dependencies,
          allTransitiveDependencies:
              LeaveShoppingBasketFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  LeaveShoppingBasketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<void> Function(LeaveShoppingBasketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LeaveShoppingBasketProvider._internal(
        (ref) => create(ref as LeaveShoppingBasketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _LeaveShoppingBasketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveShoppingBasketProvider && other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LeaveShoppingBasketRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _LeaveShoppingBasketProviderElement
    extends AutoDisposeFutureProviderElement<void> with LeaveShoppingBasketRef {
  _LeaveShoppingBasketProviderElement(super.provider);

  @override
  String get basketId => (origin as LeaveShoppingBasketProvider).basketId;
}

String _$getShoppingBasketItemsHash() =>
    r'874b79d8fd5f059d42f6117cd38936cdad8173da';

/// --- 📋 GET SHOPPING BASKET ITEMS ---
///
/// Copied from [getShoppingBasketItems].
@ProviderFor(getShoppingBasketItems)
const getShoppingBasketItemsProvider = GetShoppingBasketItemsFamily();

/// --- 📋 GET SHOPPING BASKET ITEMS ---
///
/// Copied from [getShoppingBasketItems].
class GetShoppingBasketItemsFamily
    extends Family<AsyncValue<List<GetShoppingBasketItemResponse>>> {
  /// --- 📋 GET SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [getShoppingBasketItems].
  const GetShoppingBasketItemsFamily();

  /// --- 📋 GET SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [getShoppingBasketItems].
  GetShoppingBasketItemsProvider call({
    required String basketId,
  }) {
    return GetShoppingBasketItemsProvider(
      basketId: basketId,
    );
  }

  @override
  GetShoppingBasketItemsProvider getProviderOverride(
    covariant GetShoppingBasketItemsProvider provider,
  ) {
    return call(
      basketId: provider.basketId,
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
  String? get name => r'getShoppingBasketItemsProvider';
}

/// --- 📋 GET SHOPPING BASKET ITEMS ---
///
/// Copied from [getShoppingBasketItems].
class GetShoppingBasketItemsProvider
    extends AutoDisposeFutureProvider<List<GetShoppingBasketItemResponse>> {
  /// --- 📋 GET SHOPPING BASKET ITEMS ---
  ///
  /// Copied from [getShoppingBasketItems].
  GetShoppingBasketItemsProvider({
    required String basketId,
  }) : this._internal(
          (ref) => getShoppingBasketItems(
            ref as GetShoppingBasketItemsRef,
            basketId: basketId,
          ),
          from: getShoppingBasketItemsProvider,
          name: r'getShoppingBasketItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getShoppingBasketItemsHash,
          dependencies: GetShoppingBasketItemsFamily._dependencies,
          allTransitiveDependencies:
              GetShoppingBasketItemsFamily._allTransitiveDependencies,
          basketId: basketId,
        );

  GetShoppingBasketItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.basketId,
  }) : super.internal();

  final String basketId;

  @override
  Override overrideWith(
    FutureOr<List<GetShoppingBasketItemResponse>> Function(
            GetShoppingBasketItemsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetShoppingBasketItemsProvider._internal(
        (ref) => create(ref as GetShoppingBasketItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        basketId: basketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<GetShoppingBasketItemResponse>>
      createElement() {
    return _GetShoppingBasketItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetShoppingBasketItemsProvider &&
        other.basketId == basketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, basketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetShoppingBasketItemsRef
    on AutoDisposeFutureProviderRef<List<GetShoppingBasketItemResponse>> {
  /// The parameter `basketId` of this provider.
  String get basketId;
}

class _GetShoppingBasketItemsProviderElement
    extends AutoDisposeFutureProviderElement<
        List<GetShoppingBasketItemResponse>> with GetShoppingBasketItemsRef {
  _GetShoppingBasketItemsProviderElement(super.provider);

  @override
  String get basketId => (origin as GetShoppingBasketItemsProvider).basketId;
}

String _$uncheckoutShoppingBasketItemHash() =>
    r'78367ed95ed5096a7d33b654dd032103fba8d891';

/// See also [uncheckoutShoppingBasketItem].
@ProviderFor(uncheckoutShoppingBasketItem)
const uncheckoutShoppingBasketItemProvider =
    UncheckoutShoppingBasketItemFamily();

/// See also [uncheckoutShoppingBasketItem].
class UncheckoutShoppingBasketItemFamily extends Family<AsyncValue<void>> {
  /// See also [uncheckoutShoppingBasketItem].
  const UncheckoutShoppingBasketItemFamily();

  /// See also [uncheckoutShoppingBasketItem].
  UncheckoutShoppingBasketItemProvider call({
    required UncheckoutShoppingBasketItemsRequest request,
  }) {
    return UncheckoutShoppingBasketItemProvider(
      request: request,
    );
  }

  @override
  UncheckoutShoppingBasketItemProvider getProviderOverride(
    covariant UncheckoutShoppingBasketItemProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'uncheckoutShoppingBasketItemProvider';
}

/// See also [uncheckoutShoppingBasketItem].
class UncheckoutShoppingBasketItemProvider
    extends AutoDisposeFutureProvider<void> {
  /// See also [uncheckoutShoppingBasketItem].
  UncheckoutShoppingBasketItemProvider({
    required UncheckoutShoppingBasketItemsRequest request,
  }) : this._internal(
          (ref) => uncheckoutShoppingBasketItem(
            ref as UncheckoutShoppingBasketItemRef,
            request: request,
          ),
          from: uncheckoutShoppingBasketItemProvider,
          name: r'uncheckoutShoppingBasketItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uncheckoutShoppingBasketItemHash,
          dependencies: UncheckoutShoppingBasketItemFamily._dependencies,
          allTransitiveDependencies:
              UncheckoutShoppingBasketItemFamily._allTransitiveDependencies,
          request: request,
        );

  UncheckoutShoppingBasketItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final UncheckoutShoppingBasketItemsRequest request;

  @override
  Override overrideWith(
    FutureOr<void> Function(UncheckoutShoppingBasketItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UncheckoutShoppingBasketItemProvider._internal(
        (ref) => create(ref as UncheckoutShoppingBasketItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UncheckoutShoppingBasketItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UncheckoutShoppingBasketItemProvider &&
        other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UncheckoutShoppingBasketItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  UncheckoutShoppingBasketItemsRequest get request;
}

class _UncheckoutShoppingBasketItemProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UncheckoutShoppingBasketItemRef {
  _UncheckoutShoppingBasketItemProviderElement(super.provider);

  @override
  UncheckoutShoppingBasketItemsRequest get request =>
      (origin as UncheckoutShoppingBasketItemProvider).request;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
