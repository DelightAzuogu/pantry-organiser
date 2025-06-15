import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/auth/auth.dart';
import 'package:pantry_organiser_frontend/home/home.dart';
import 'package:pantry_organiser_frontend/l10n/l10n.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';
import 'package:pantry_organiser_frontend/recipe/views/views.dart';
import 'package:pantry_organiser_frontend/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationControllerProvider);

    return MaterialApp(
      theme: LightAppTheme().lightTheme,
      darkTheme: DarkAppTheme().darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const Home(),
        '/login': (context) => LoginPage(),
        '/pantryItems': (context) => const PantryItemsPage(),
        '/addPantryItem': (context) => const AddPantryItemPage(),
        '/recipes': (context) => const UserRecipes(),
        '/createRecipe': (context) => const CreateRecipe(),
      },
      initialRoute: authState.when(
        unAuthenticated: () => '/login',
        authenticated: (_) => '/home',
      ),
    );
  }
}
