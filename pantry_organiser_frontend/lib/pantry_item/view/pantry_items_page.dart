import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_scaffold.dart';
import 'package:pantry_organiser_frontend/pantry_item/widget/pantry_item_list.dart';

class PantryItemsPage extends ConsumerWidget {
  const PantryItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomScaffold(
      title: 'Pantry Items',
      body: PantryItemList(),
    );
  }
}
