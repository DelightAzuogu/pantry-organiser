import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/helpers/showCustomToast.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authenticationControllerProvider, (_, next) {
      next.maybeWhen(
        unAuthenticated: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        orElse: () {
          showCustomToast(message: 'Failed to log out up 🚩');
        },
      );
    });

    final authController = ref.watch(authenticationControllerProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'Pantry Organiser',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.kitchen_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Pantry',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  tileColor: Colors.transparent,
                  hoverColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.menu_book_outlined,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                //   title: Text(
                //     'Recipes',
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.pushReplacementNamed(context, '/recipe');
                //   },
                //   tileColor: Colors.transparent,
                //   hoverColor: Theme.of(context).colorScheme.primaryContainer,
                // ),
              ],
            ),
          ),
          // Logout button at the bottom
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.red,
                  ),
            ),
            onTap: () async {
              await authController.logout();
            },
            tileColor: Colors.transparent,
          ),
          const Gap(32)
        ],
      ),
    );
  }
}
