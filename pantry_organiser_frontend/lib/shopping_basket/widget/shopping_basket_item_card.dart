import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_items_response.dart';

class ShoppingBasketItemCard extends StatelessWidget {
  const ShoppingBasketItemCard({
    required this.item,
    this.onCheckChanged,
    this.onEdit,
    this.onDelete,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onSelectionChanged,
    this.isLoading = false,
    super.key,
  });

  final GetShoppingBasketItemResponse item;
  final ValueChanged<bool>? onCheckChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: item.isChecked ? 0.5 : 2,
      color: isSelectionMode && isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelectionMode && isSelected
            ? BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              )
            : isSelectionMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: onSelectionChanged != null
                        ? (value) => onSelectionChanged!(value ?? false)
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )
                : Checkbox(
                    value: item.isChecked,
                    onChanged: onCheckChanged != null
                        ? (value) {
                            if (value != null) {
                              onCheckChanged!(value);
                            }
                          }
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
        title: Text(
          item.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            decoration: item.isChecked ? TextDecoration.lineThrough : null,
            color: item.isChecked
                ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          '${item.quantity} ${item.quantityUnit.name}',
          style: theme.textTheme.bodySmall?.copyWith(
            decoration: item.isChecked ? TextDecoration.lineThrough : null,
            color: item.isChecked
                ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        trailing: isSelectionMode || item.isChecked
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: onEdit,
                      tooltip: 'Edit',
                      color: theme.colorScheme.primary,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: onDelete,
                      tooltip: 'Delete',
                      color: theme.colorScheme.error,
                    ),
                ],
              ),
        onTap: isSelectionMode && onSelectionChanged != null
            ? () => onSelectionChanged!(!isSelected)
            : null,
      ),
    );
  }
}
