import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/custom_toast.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';

class RecipeViewPage extends ConsumerStatefulWidget {
  const RecipeViewPage({super.key});

  @override
  ConsumerState createState() => _RecipeViewPageState();
}

class _RecipeViewPageState extends ConsumerState<RecipeViewPage> {
  Future<void> _refreshRecipeDetails() async {
    ref.invalidate(getRecipeDetailsProvider);
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: const Text(
          'Are you sure you want to delete this recipe? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              await ref
                  .read(
                    userRecipesControllerProvider.notifier,
                  )
                  .deleteRecipe(
                    ref.read(selectedRecipeIdProvider)!,
                  );
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Delete'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userRecipesControllerProvider, (_, next) {
      if (next.isDeleted) {
        showCustomToast(message: 'Successfully deleted the recipe');
        Navigator.of(context).pop();
      }
    });

    final recipeId = ref.watch(selectedRecipeIdProvider)!;
    final asyncValue = ref.watch(getRecipeDetailsProvider(recipeId: recipeId));

    return CustomScaffold(
      title: 'Recipe Details',
      body: asyncValue.when(
        data: (recipeDetails) {
          return RefreshIndicator(
            onRefresh: _refreshRecipeDetails,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Header
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  recipeDetails.name,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              if (recipeDetails.isOwner) ...[
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                          selectedRecipeProvider.notifier,
                                        )
                                        .state = recipeDetails;
                                    Navigator.of(context).pushNamed(
                                      '/editRecipe',
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  tooltip: 'Edit Recipe',
                                ),
                                IconButton(
                                  onPressed: () => _showDeleteDialog(context),
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  tooltip: 'Delete Recipe',
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (recipeDetails.description != null && recipeDetails.description!.isNotEmpty)
                            Text(
                              recipeDetails.description!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          const SizedBox(height: 16),
                          // Recipe Info Row
                          Row(
                            children: [
                              Expanded(
                                child: _InfoCard(
                                  icon: Icons.people,
                                  label: 'Servings',
                                  value: '${recipeDetails.servingSize}',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _InfoCard(
                                  icon: Icons.schedule,
                                  label: 'Prep Time',
                                  value: _formatDuration(
                                    recipeDetails.prepTime,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _InfoCard(
                                  icon: Icons.timer,
                                  label: 'Cook Time',
                                  value: _formatDuration(
                                    recipeDetails.cookTime,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Ingredients Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Ingredients',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (recipeDetails.ingredients.isEmpty)
                            const Center(
                              child: Text('No ingredients listed'),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recipeDetails.ingredients.length,
                              separatorBuilder: (context, index) => const Divider(),
                              itemBuilder: (context, index) {
                                final ingredient = recipeDetails.ingredients[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).primaryColor.withOpacity(0.1),
                                    child: Text(
                                      ingredient.name[0].toUpperCase(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    ingredient.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${ingredient.quantity} ${ingredient.quantityUnit.name}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Instructions Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.list_alt,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Instructions',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (recipeDetails.instructions != null && recipeDetails.instructions!.isNotEmpty)
                            Text(
                              recipeDetails.instructions!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          else
                            const Text(
                              'No instructions provided',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        loading: () => const CustomLoadingWidget(),
        error: (error, stackTrace) => CustomErrorWidget(
          onRetry: _refreshRecipeDetails,
          message: 'Failed to load recipe details',
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
