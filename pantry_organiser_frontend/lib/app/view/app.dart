import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/Auth/auth.dart';
import 'package:pantry_organiser_frontend/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
        '/login': (context) => SignUpPage(),
      },
      initialRoute: '/login',
    );
  }
}
