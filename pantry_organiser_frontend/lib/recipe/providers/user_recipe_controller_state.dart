import 'package:equatable/equatable.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class UserRecipeControllerState extends Equatable {
  const UserRecipeControllerState({
    this.recipes = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasGottenRecipes = false,
    this.isCreated = false,
    this.isDeleted = false,
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
    bool? isDeleted,
  }) : this(
          recipes: recipes,
          isLoading: false,
          errorMessage: null,
          hasGottenRecipes: true,
          isCreated: isCreated ?? false,
          isDeleted: isDeleted ?? false,
        );

  final String? errorMessage;
  final bool? hasGottenRecipes;
  final bool isLoading;
  final List<RecipesModel> recipes;
  final bool isCreated;
  final bool isDeleted;

  UserRecipeControllerState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    List<RecipesModel>? recipes,
    bool? hasGottenRecipes,
    bool? isCreated,
    bool? isDeleted,
  }) {
    return UserRecipeControllerState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      recipes: recipes ?? this.recipes,
      hasGottenRecipes: hasGottenRecipes ?? this.hasGottenRecipes,
      isCreated: isCreated ?? this.isCreated,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        recipes,
        isLoading,
        errorMessage,
      ];
}
