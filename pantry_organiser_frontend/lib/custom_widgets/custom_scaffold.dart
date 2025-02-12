import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
    super.key,
  });

  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(title),
        actions: actions,
      ),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
