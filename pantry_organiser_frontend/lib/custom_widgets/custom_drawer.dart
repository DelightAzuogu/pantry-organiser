import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/helpers/custom_toast.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authenticationControllerProvider,
      (_, next) {
        next.maybeWhen(
          unAuthenticated: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          orElse: () {
            showCustomToast(message: 'Failed to log out up 🚩');
          },
        );
      },
    );

    final authController = ref.watch(authenticationControllerProvider.notifier);

    return SafeArea(
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: Drawer(
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      'Pantry Organiser',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.kitchen_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Pantry',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.utensils,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Recipes',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/recipes');
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Logout',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                      ),
                      onTap: () async {
                        await authController.logout();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
