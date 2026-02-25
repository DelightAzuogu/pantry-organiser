import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_items_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/shopping_basket/providers/shopping_basket_controller.dart';
import 'package:pantry_organiser_frontend/shopping_basket/providers/shopping_basket_providers.dart';
import 'package:pantry_organiser_frontend/shopping_basket/widget/shopping_basket_item_card.dart';

class ShoppingBasketDetailsPage extends ConsumerStatefulWidget {
  const ShoppingBasketDetailsPage({super.key});

  @override
  ConsumerState createState() => _ShoppingBasketDetailsPageState();
}

class _ShoppingBasketDetailsPageState
    extends ConsumerState<ShoppingBasketDetailsPage> {
  late GetShoppingBasketResponse basket;

  // Add state for selection mode
  bool _isSelectionMode = false;
  final Set<String> _selectedItemIds = {};
  final Set<String> _loadingItemIds = {};

  @override
  void initState() {
    super.initState();

    final selectedBasket = ref.read(selectedShoppingBasketProvider);
    if (selectedBasket == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      basket = selectedBasket;
    }
  }

  Future<void> _refreshBasketDetails() async {
    ref.invalidate(getShoppingBasketItemsProvider(basketId: basket.id));
    // Clear selection after refresh
    setState(() {
      _selectedItemIds.clear();
      _isSelectionMode = false;
    });
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedItemIds.clear();
      }
    });
  }

  void _toggleItemSelection(String itemId) {
    setState(() {
      if (_selectedItemIds.contains(itemId)) {
        _selectedItemIds.remove(itemId);
      } else {
        _selectedItemIds.add(itemId);
      }
    });
  }

  void _selectAllUncheckedItems(List<GetShoppingBasketItemResponse> items) {
    setState(() {
      final uncheckedItems = items.where((item) => !item.isChecked);
      _selectedItemIds.clear();
      _selectedItemIds.addAll(uncheckedItems.map((item) => item.id));
    });
  }

  Future<void> _checkSelectedItems() async {
    if (_selectedItemIds.isEmpty) {
      await showCustomToast(message: 'No items selected');
      return;
    }

    final request = CheckoutShoppingBasketItemsRequest(
      shoppingBasketItemIds: _selectedItemIds.toList(),
      shoppingBasketId: basket.id,
    );

    await ref.read(
      checkoutShoppingBasketItemsProvider(request: request).future,
    );

    await showCustomToast(
      message: '${_selectedItemIds.length} item(s) checked off',
    );
    await _refreshBasketDetails();
  }

  void _showDeleteBasketDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Shopping Basket'),
        content: const Text(
          'Are you sure you want to delete this shopping basket? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              await ref
                  .read(shoppingBasketControllerProvider.notifier)
                  .deleteShoppingBasket(basket.id)
                  .whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
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

  void _showEditBasketDialog(BuildContext context) {
    final nameController = TextEditingController(text: basket.name);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Shopping Basket'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Basket Name',
            hintText: 'Enter basket name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                await showCustomToast(message: 'Please enter a basket name');
                return;
              }

              await ref
                  .read(shoppingBasketControllerProvider.notifier)
                  .updateShoppingBasket(basket.id, nameController.text.trim());

              if (context.mounted) {
                Navigator.of(context).pop();
                // Update the basket name
                setState(() {
                  basket = basket.copyWith(name: nameController.text.trim());
                });
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    QuantityUnit selectedUnit = QuantityUnit.gram;

    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Enter quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<QuantityUnit>(
                  value: selectedUnit,
                  decoration: const InputDecoration(
                    labelText: 'Unit',
                    border: OutlineInputBorder(),
                  ),
                  items: QuantityUnit.values.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedUnit = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            AsyncButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) {
                  await showCustomToast(message: 'Please enter an item name');
                  return;
                }
                if (quantityController.text.trim().isEmpty) {
                  await showCustomToast(message: 'Please enter a quantity');
                  return;
                }

                final request = AddItemToShoppingBasket(
                  shoppingBasketId: basket.id,
                  name: nameController.text.trim(),
                  quantity: int.parse(quantityController.text),
                  quantityUnit: selectedUnit,
                );

                await ref.read(
                  addItemToShoppingBasketProvider(request: request).future,
                );

                await showCustomToast(message: 'Item added successfully');
                await _refreshBasketDetails();

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditItemDialog(
    BuildContext context,
    GetShoppingBasketItemResponse item,
  ) {
    final nameController = TextEditingController(text: item.name);
    final quantityController =
        TextEditingController(text: item.quantity.toString());
    QuantityUnit selectedUnit = item.quantityUnit;

    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Enter quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<QuantityUnit>(
                  value: selectedUnit,
                  decoration: const InputDecoration(
                    labelText: 'Unit',
                    border: OutlineInputBorder(),
                  ),
                  items: QuantityUnit.values.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(unit.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedUnit = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            AsyncButton(
              onPressed: () async {
                if (nameController.text.trim().isEmpty) {
                  await showCustomToast(message: 'Please enter an item name');
                  return;
                }
                if (quantityController.text.trim().isEmpty) {
                  await showCustomToast(message: 'Please enter a quantity');
                  return;
                }

                final request = UpdateShoppingBasketItemRequest(
                  id: item.id,
                  name: nameController.text.trim(),
                  quantity: int.parse(quantityController.text),
                  quantityUnit: selectedUnit,
                );

                await ref.read(
                  updateShoppingBasketItemProvider(request: request).future,
                );

                await showCustomToast(message: 'Item updated successfully');
                await _refreshBasketDetails();

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteItemDialog(
    BuildContext context,
    GetShoppingBasketItemResponse item,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              await ref.read(
                deleteShoppingBasketItemProvider(itemId: item.id).future,
              );

              await showCustomToast(message: 'Item deleted successfully');
              await _refreshBasketDetails();

              if (context.mounted) {
                Navigator.of(context).pop();
              }
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

  void _showShareDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Shopping Basket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Share this unique code with others:'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      basket.uniqueString,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: basket.uniqueString),
                      );
                      await showCustomToast(
                        message: 'Copied to clipboard',
                      );
                    },
                    tooltip: 'Copy',
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCheckItem(
    GetShoppingBasketItemResponse item,
    bool isChecked,
  ) async {
    // Mark item as loading
    setState(() {
      _loadingItemIds.add(item.id);
    });

    try {
      if (isChecked) {
        // Checking - use batch with single item
        final request = CheckoutShoppingBasketItemsRequest(
          shoppingBasketItemIds: [item.id],
          shoppingBasketId: basket.id,
        );

        await ref.read(
          checkoutShoppingBasketItemsProvider(request: request).future,
        );
      } else {
        // Unchecking - use individual uncheckout
        final request = UncheckoutShoppingBasketItemsRequest(
          shoppingBasketItemId: item.id,
          shoppingBasketId: basket.id,
        );

        await ref.read(
          uncheckoutShoppingBasketItemProvider(request: request).future,
        );
      }

      await _refreshBasketDetails();
    } finally {
      // Remove loading state
      if (mounted) {
        setState(() {
          _loadingItemIds.remove(item.id);
        });
      }
    }
  }

  void _showCloseBasketDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Close Shopping Basket'),
        content: const Text(
          'Are you sure you want to close this shopping basket? '
          'You will no longer be able to add or modify items.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              await ref
                  .read(shoppingBasketControllerProvider.notifier)
                  .closeShoppingBasket(basket.id)
                  .whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  void _showLeaveBasketDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Shopping Basket'),
        content: const Text(
          'Are you sure you want to leave this shopping basket? '
          'You will no longer have access to it unless you are invited again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              try {
                await ref.read(
                  leaveShoppingBasketProvider(basketId: basket.id).future,
                );

                if (context.mounted) {
                  await showCustomToast(
                    message: 'Left "${basket.name}" successfully',
                  );

                  // Refresh the baskets list
                  ref.invalidate(getUserOpenShoppingBasketsProvider);
                  ref
                      .read(shoppingBasketControllerProvider.notifier)
                      .getOpenShoppingBaskets();

                  // Close dialog and navigate back
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (context.mounted) {
                  await showCustomToast(
                    message: 'Failed to leave basket',
                  );
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Leave'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asyncValue = ref.watch(
      getShoppingBasketItemsProvider(basketId: basket.id),
    );

    return CustomScaffold(
      title: basket.name,
      actions: [
        if (_isSelectionMode && asyncValue.hasValue) ...[
          TextButton.icon(
            onPressed: () => _selectAllUncheckedItems(asyncValue.value!),
            icon: const Icon(Icons.select_all),
            label: const Text('Select All'),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _toggleSelectionMode,
            tooltip: 'Cancel',
          ),
        ] else ...[
          if (basket.isOwner) ...[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _showShareDialog(context),
              tooltip: 'Share',
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                switch (value) {
                  case 'users':
                    Navigator.pushNamed(context, '/basketUsers');
                    break;
                  case 'edit':
                    _showEditBasketDialog(context);
                    break;
                  case 'close':
                    _showCloseBasketDialog(context);
                    break;
                  case 'delete':
                    _showDeleteBasketDialog(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'users',
                  child: Row(
                    children: [
                      Icon(Icons.people),
                      SizedBox(width: 8),
                      Text('Manage Users'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'close',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(width: 8),
                      Text('Close Basket'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'leave') {
                  _showLeaveBasketDialog(context);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'leave',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('Leave Basket',
                          style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ],
      body: asyncValue.when(
        data: (items) {
          return RefreshIndicator(
            onRefresh: _refreshBasketDetails,
            child: _buildContent(theme, items),
          );
        },
        loading: () => const CustomLoadingWidget(),
        error: (error, stackTrace) => CustomErrorWidget(
          onRetry: _refreshBasketDetails,
          message: 'Failed to load shopping basket items',
        ),
      ),
      floatingActionButton: basket.isOwner
          ? (_isSelectionMode
              ? FloatingActionButton.extended(
                  onPressed: _checkSelectedItems,
                  backgroundColor: theme.colorScheme.primary,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    'Check ${_selectedItemIds.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : FloatingActionButton(
                  onPressed: () => _showAddItemDialog(context),
                  backgroundColor: theme.colorScheme.primary,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ))
          : null,
    );
  }

  Widget _buildContent(
      ThemeData theme, List<GetShoppingBasketItemResponse> items) {
    if (items.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Separate checked and unchecked items
    final uncheckedItems = items.where((item) => !item.isChecked).toList();
    final checkedItems = items.where((item) => item.isChecked).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Basket Info Card
          _buildInfoCard(theme, items),
          const SizedBox(height: 16),

          // Unchecked Items
          if (uncheckedItems.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items to Buy (${uncheckedItems.length})',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!_isSelectionMode &&
                    uncheckedItems.isNotEmpty &&
                    basket.isOwner)
                  TextButton.icon(
                    onPressed: _toggleSelectionMode,
                    icon: const Icon(Icons.checklist, size: 20),
                    label: const Text('Select'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ...uncheckedItems.map(
              (item) => ShoppingBasketItemCard(
                item: item,
                isSelectionMode: _isSelectionMode,
                isSelected: _selectedItemIds.contains(item.id),
                onSelectionChanged: _isSelectionMode
                    ? (selected) => _toggleItemSelection(item.id)
                    : null,
                onCheckChanged: !_isSelectionMode
                    ? (isChecked) => _handleCheckItem(item, isChecked)
                    : null,
                onEdit: !_isSelectionMode && basket.isOwner
                    ? () => _showEditItemDialog(context, item)
                    : null,
                onDelete: !_isSelectionMode && basket.isOwner
                    ? () => _showDeleteItemDialog(context, item)
                    : null,
                isLoading: _loadingItemIds.contains(item.id),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Checked Items
          if (checkedItems.isNotEmpty) ...[
            Text(
              'Purchased (${checkedItems.length})',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 12),
            ...checkedItems.map(
              (item) => ShoppingBasketItemCard(
                item: item,
                isSelectionMode: false,
                isSelected: false,
                isLoading: _loadingItemIds.contains(item.id),
                onCheckChanged: (isChecked) =>
                    _handleCheckItem(item, isChecked),
                onEdit: basket.isOwner
                    ? () => _showEditItemDialog(context, item)
                    : null,
                onDelete: basket.isOwner
                    ? () => _showDeleteItemDialog(context, item)
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      ThemeData theme, List<GetShoppingBasketItemResponse> items) {
    final totalItems = items.length;
    final checkedItems = items.where((item) => item.isChecked).length;
    final progress = totalItems > 0 ? checkedItems / totalItems : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$checkedItems of $totalItems items',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    '${(progress * 100).toInt()}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (basket.isOwner)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Owner',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'View Only',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No items in this basket',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first item to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
