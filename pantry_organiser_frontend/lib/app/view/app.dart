import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/home/home.dart';
import 'package:pantry_organiser_frontend/l10n/l10n.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';
import 'package:pantry_organiser_frontend/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationControllerProvider);

    return MaterialApp(
      theme: AppTheme().lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const Home(),
        '/login': (context) => LoginPage(),
        '/pantryItems': (context) => const PantryItemsPage(),
      },
      initialRoute: authState.when(
        unAuthenticated: () => '/login',
        authenticated: (_) => '/home',
      ),
    );
  }
}
