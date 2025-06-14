import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class UserRecipeControllerState extends Equatable {
  const UserRecipeControllerState({
    this.recipes = const [],
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.hasGottenRecipes = false,
  });

  /// Named constructor for loading state
  const UserRecipeControllerState.loading()
      : this(
          isLoading: true,
        );

  /// Named constructor for error state
  const UserRecipeControllerState.error(
    String error,
  ) : this(
          errorMessage: error,
          successMessage: null,
          isLoading: false,
          hasGottenRecipes: false,
        );

  /// Named constructor for success state
  const UserRecipeControllerState.success(
    List<RecipesModel> recipes, {
    String? successMessage,
  }) : this(
          recipes: recipes,
          isLoading: false,
          errorMessage: null,
          hasGottenRecipes: true,
          successMessage: successMessage,
        );

  final String? errorMessage;
  final bool? hasGottenRecipes;
  final String? successMessage;
  final bool isLoading;
  final List<RecipesModel> recipes;

  UserRecipeControllerState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    List<RecipesModel>? recipes,
  }) {
    return UserRecipeControllerState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object?> get props => [
        recipes,
        isLoading,
        successMessage,
        errorMessage,
      ];
}
