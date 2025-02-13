import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_scaffold.dart';
import 'package:pantry_organiser_frontend/pantry_item/widget/widget.dart';

class PantryItemsPage extends ConsumerWidget {
  const PantryItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Pantry Items',
      body: const PantryItemList(),
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
