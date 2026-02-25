import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RecipeBasicInfoSection extends StatelessWidget {
  const RecipeBasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Recipe Name
        ReactiveTextField<String>(
          formControlName: 'name',
          decoration: const InputDecoration(
            labelText: 'Recipe Name *',
            border: OutlineInputBorder(),
            hintText: 'Enter recipe name',
          ),
          validationMessages: {
            ValidationMessage.required: (error) => 'Recipe name is required',
          },
        ),
        const SizedBox(height: 16),

        // Description
        ReactiveTextField<String>(
          formControlName: 'description',
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            hintText: 'Enter recipe description (optional)',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 16),

        // Serving Size
        ReactiveTextField<int>(
          formControlName: 'servingSize',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Serving Size *',
            border: OutlineInputBorder(),
            hintText: 'Number of servings',
            suffixText: 'servings',
          ),
          validationMessages: {
            ValidationMessage.required: (error) => 'Serving size is required',
            ValidationMessage.min: (error) => 'Serving size must be at least 1',
          },
        ),
      ],
    );
  }
}
