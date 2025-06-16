import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';

class UserRecipes extends ConsumerStatefulWidget {
  const UserRecipes({super.key});

  @override
  ConsumerState createState() => _UserRecipesState();
}

class _UserRecipesState extends ConsumerState<UserRecipes> {
  late bool isLoading;
  late String? errorMessage;
  late List<RecipesModel> recipes;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    errorMessage = null;
    recipes = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userRecipesControllerProvider.notifier).getRecipes();
    });
  }

  void _onRefresh() {
    ref.read(userRecipesControllerProvider.notifier).getRecipes();
  }

  void _onRecipeTap(RecipesModel recipe) {
    ref.read(selectedRecipeIdProvider.notifier).state = recipe.id;

    Navigator.pushNamed(
      context,
      '/recipeDetails',
      arguments: recipe,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(userRecipesControllerProvider, (_, next) {
      if (next.isLoading) {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });
      } else if (next.errorMessage != null) {
        setState(() {
          isLoading = false;
          errorMessage = next.errorMessage;
        });
        showCustomToast(message: next.errorMessage!);
      }

      if (true == next.hasGottenRecipes) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          recipes = next.recipes;
        });
      }
    });

    return CustomScaffold(
      title: 'Recipes',
      body: _buildBody(theme),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createRecipe');
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (isLoading) {
      return const CustomLoadingWidget();
    }

    if (errorMessage != null) {
      return CustomErrorWidget(
        message: errorMessage!,
        onRetry: _onRefresh,
      );
    }

    if (recipes.isEmpty) {
      return _buildEmptyState(theme);
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onRefresh();
      },
      child: _buildRecipesList(theme),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No recipes found',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first recipe to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesList(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return _buildRecipeCard(recipe, theme);
      },
    );
  }

  Widget _buildRecipeCard(RecipesModel recipe, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _onRecipeTap(recipe),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.restaurant,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  recipe.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
