import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class IngredientListItem extends StatelessWidget {
  const IngredientListItem({
    required this.ingredient,
    required this.onEdit,
    required this.onRemove,
    super.key,
  });

  final AddRecipeIngredientRequest ingredient;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          ingredient.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${ingredient.quantity} ${ingredient.quantityUnit.shortForm}',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              tooltip: 'Edit ingredient',
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close),
              tooltip: 'Remove ingredient',
            ),
          ],
        ),
      ),
    );
  }
}
