import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/app/view/custom_app_bar.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Do Something'),
        ),
      ),
    );
  }
}
