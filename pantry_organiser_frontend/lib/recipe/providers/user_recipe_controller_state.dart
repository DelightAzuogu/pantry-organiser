import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class UserRecipeControllerState extends Equatable {
  const UserRecipeControllerState({
    this.recipes = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasGottenRecipes = false,
    this.isCreated = false,
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
          isLoading: false,
          hasGottenRecipes: false,
        );

  /// Named constructor for success state
  const UserRecipeControllerState.success(
    List<RecipesModel> recipes, {
    bool? isCreated,
  }) : this(
          recipes: recipes,
          isLoading: false,
          errorMessage: null,
          hasGottenRecipes: true,
          isCreated: isCreated ?? false,
        );

  final String? errorMessage;
  final bool? hasGottenRecipes;
  final bool isLoading;
  final List<RecipesModel> recipes;
  final bool isCreated;

  UserRecipeControllerState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    List<RecipesModel>? recipes,
  }) {
    return UserRecipeControllerState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object?> get props => [
        recipes,
        isLoading,
        errorMessage,
      ];
}
