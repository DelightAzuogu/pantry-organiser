import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_scaffold.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';
import 'package:pantry_organiser_frontend/pantry_item/widget/widget.dart';

class PantryItemsPage extends ConsumerWidget {
  const PantryItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pantry = ref.watch(selectedPantryProvider)!;

    return CustomScaffold(
      title: 'Pantry Items',
      body: const PantryItemList(),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            try {
              await ref
                  .watch(
                    pantryApiProvider,
                  )
                  .deletePantry(
                    pantry.id,
                  );

              await showCustomToast(
                message: 'Pantry deleted successfully',
              );
              ref.invalidate(getUserPantriesProvider);

              await Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            } catch (error) {
              await showCustomToast(
                message: 'Error deleting pantry',
              );
            }
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPantryItem');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
