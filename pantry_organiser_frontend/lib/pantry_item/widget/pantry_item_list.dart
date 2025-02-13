import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';
import 'package:pantry_organiser_frontend/pantry_item/widget/widget.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: pantryItemsAsyncValue.when(
          data: (pantryItems) {
            if (pantryItems.isEmpty) {
              return Center(
                child: Text(
                  'No items in this pantry yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            return ListView.builder(
              itemCount: pantryItems.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: PantryItemCard(
                  item: pantryItems[index],
                ),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
