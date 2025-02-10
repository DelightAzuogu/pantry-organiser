import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  Future<void> _showCreatePantryDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => const CreatePantryDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Home',
      body: const UserPantriesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePantryDialog(context, ref),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
