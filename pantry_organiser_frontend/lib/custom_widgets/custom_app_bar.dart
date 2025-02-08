import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/helpers/showCustomToast.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authenticationControllerProvider, (_, next) {
      next.maybeWhen(
        unAuthenticated: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        orElse: () {
          showCustomToast(message: 'Failed to sign user up 🚩');
        },
      );
    });

    final authController = ref.watch(authenticationControllerProvider.notifier);

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () async {
            await authController.logout();
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
