import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RecipeInstructionsSection extends StatelessWidget {
  const RecipeInstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: 'instructions',
      minLines: 5,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Instructions',
        border: OutlineInputBorder(),
        hintText: 'Enter cooking instructions (optional)',
        alignLabelWithHint: true,
      ),
    );
  }
}
