import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';

class UserPantriesList extends ConsumerWidget {
  const UserPantriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPantriesAsyncValue = ref.watch(getUserPantriesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        return ref.refresh(getUserPantriesProvider);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: userPantriesAsyncValue.when(
                data: (userPantries) {
                  if (userPantries.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Text(
                          'No pantries found. Create one to get started!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: userPantries.map((pantry) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              pantry.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              ref.read(selectedPantryProvider.notifier).state = pantry;
                              Navigator.pushNamed(context, '/pantryItems');
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Error loading pantries',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.refresh(
                              getUserPantriesProvider,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
