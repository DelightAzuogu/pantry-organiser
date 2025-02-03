import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/Auth/auth.dart';
import 'package:pantry_organiser_frontend/home/home.dart';
import 'package:pantry_organiser_frontend/l10n/l10n.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationControllerProvider);

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => const Home(),
      },
      initialRoute: authState.when(
        unAuthenticated: () => '/signUp',
        authenticated: (_) => '/home',
      ),
    );
  }
}
