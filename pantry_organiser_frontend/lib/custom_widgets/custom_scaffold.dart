import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final canPop = Navigator.canPop(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: actions,
        title: Row(
          children: [
            if (canPop)
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            else
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            const Gap(10),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
    );
  }
}
