import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';

class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection({
    required this.ingredients,
    required this.onAddIngredient,
    required this.onUpdateIngredient,
    required this.onRemoveIngredient,
    super.key,
  });

  final List<AddRecipeIngredientRequest> ingredients;
  final Function(AddRecipeIngredientRequest) onAddIngredient;
  final Function(int, AddRecipeIngredientRequest) onUpdateIngredient;
  final Function(int) onRemoveIngredient;

  void _showAddIngredientDialog(BuildContext context, [int? editIndex]) {
    final isEditing = editIndex != null;
    final existingIngredient = isEditing ? ingredients[editIndex] : null;

    showDialog(
      context: context,
      builder: (context) => AddIngredientDialog(
        existingIngredient: existingIngredient,
        onSubmit: (ingredient) {
          if (isEditing) {
            onUpdateIngredient(editIndex, ingredient);
          } else {
            onAddIngredient(ingredient);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddIngredientDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Ingredient'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (ingredients.isEmpty)
          _buildEmptyState()
        else
          _buildIngredientsList(
            context,
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'No ingredients added yet',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap "Add Ingredient" to get started',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsList(BuildContext context) {
    return Column(
      children: ingredients.asMap().entries.map((entry) {
        final index = entry.key;
        final ingredient = entry.value;
        return IngredientListItem(
          ingredient: ingredient,
          onEdit: () => _showAddIngredientDialog(context, index),
          onRemove: () => onRemoveIngredient(index),
        );
      }).toList(),
    );
  }
}
