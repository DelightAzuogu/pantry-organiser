import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';

class ShoppingBasketControllerState extends Equatable {
  const ShoppingBasketControllerState({
    this.shoppingBaskets = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasGottenBaskets = false,
    this.isCreated = false,
    this.isDeleted = false,
    this.isUpdated = false,
    this.isClosed = false,
  });

  /// Named constructor for loading state
  const ShoppingBasketControllerState.loading()
      : this(
          isLoading: true,
        );

  /// Named constructor for error state
  const ShoppingBasketControllerState.error(
    String error,
  ) : this(
          errorMessage: error,
          isLoading: false,
          hasGottenBaskets: false,
        );

  /// Named constructor for success state
  const ShoppingBasketControllerState.success(
    List<GetShoppingBasketResponse> baskets, {
    bool? isCreated,
    bool? isDeleted,
    bool? isUpdated,
    bool? isClosed,
  }) : this(
          shoppingBaskets: baskets,
          isLoading: false,
          errorMessage: null,
          hasGottenBaskets: true,
          isCreated: isCreated ?? false,
          isDeleted: isDeleted ?? false,
          isUpdated: isUpdated ?? false,
          isClosed: isClosed ?? false,
        );

  final String? errorMessage;
  final bool? hasGottenBaskets;
  final bool isLoading;
  final List<GetShoppingBasketResponse> shoppingBaskets;
  final bool isCreated;
  final bool isDeleted;
  final bool isUpdated;
  final bool isClosed;

  ShoppingBasketControllerState copyWith({
    String? errorMessage,
    bool? isLoading,
    List<GetShoppingBasketResponse>? shoppingBaskets,
    bool? hasGottenBaskets,
    bool? isCreated,
    bool? isDeleted,
    bool? isUpdated,
    bool? isClosed,
  }) {
    return ShoppingBasketControllerState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      shoppingBaskets: shoppingBaskets ?? this.shoppingBaskets,
      hasGottenBaskets: hasGottenBaskets ?? this.hasGottenBaskets,
      isCreated: isCreated ?? this.isCreated,
      isDeleted: isDeleted ?? this.isDeleted,
      isUpdated: isUpdated ?? this.isUpdated,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  List<Object?> get props => [
        shoppingBaskets,
        isLoading,
        errorMessage,
        hasGottenBaskets,
        isCreated,
        isDeleted,
        isUpdated,
        isClosed,
      ];
}
