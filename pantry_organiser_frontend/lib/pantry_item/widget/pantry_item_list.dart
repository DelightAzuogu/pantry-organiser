import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';

class PantryItemList extends ConsumerWidget {
  const PantryItemList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pantry = ref.watch(selectedPantryProvider)!;

    final pantryItemsAsyncValue = ref.watch(
      getPantryItemsProvider(pantryId: pantry.id),
    );

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getPantryItemsProvider(pantryId: pantry.id));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: pantryItemsAsyncValue.when(
                data: (pantryItems) {
                  if (pantryItems.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'No items in this pantry yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pantryItems.length,
                    itemBuilder: (context, index) {
                      final item = pantryItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.brand != null) Text('Brand: ${item.brand}'),
                              Text(
                                'Quantity: ${item.quantity} ${item.quantityUnit.name}',
                              ),
                              if (item.description != null)
                                Text(
                                  'Description: ${item.description}',
                                ),
                              if (item.expiryDate != null)
                                Text(
                                  'Expires: ${_formatDate(item.expiryDate!)}',
                                ),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () {
                            // TODO(Delight): Navigate to item details or edit screen
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading pantry items',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
