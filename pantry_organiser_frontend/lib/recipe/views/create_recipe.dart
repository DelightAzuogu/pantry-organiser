import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateRecipe extends ConsumerStatefulWidget {
  const CreateRecipe({super.key});

  @override
  ConsumerState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends ConsumerState<CreateRecipe> {
  late FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(
        validators: [Validators.required],
      ),
      'description': FormControl<String>(),
      'instructions': FormControl<String>(),
      'servingSize': FormControl<int>(
        validators: [
          Validators.required,
          Validators.min(1),
        ],
      ),
      'prepHours': FormControl<int>(
        value: 0,
        validators: [Validators.min(0)],
      ),
      'prepMinutes': FormControl<int>(
        value: 0,
        validators: [
          Validators.min(0),
          Validators.max(59),
        ],
      ),
      'cookHours': FormControl<int>(
        value: 0,
        validators: [Validators.min(0)],
      ),
      'cookMinutes': FormControl<int>(
        value: 0,
        validators: [
          Validators.min(0),
          Validators.max(59),
        ],
      ),
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (form.valid) {
      final formValue = form.value;

      final request = AddRecipeRequest(
        name: formValue['name']! as String,
        description:
            true == (formValue['description'] as String?)?.isNotEmpty ? formValue['description'] as String? : null,
        instructions:
            true == (formValue['instructions'] as String?)?.isNotEmpty ? formValue['instructions'] as String? : null,
        servingSize: formValue['servingSize']! as int,
        prepTime: Duration(
          hours: formValue['prepHours'] as int? ?? 0,
          minutes: formValue['prepMinutes'] as int? ?? 0,
        ),
        cookTime: Duration(
          hours: formValue['cookHours'] as int? ?? 0,
          minutes: formValue['cookMinutes'] as int? ?? 0,
        ),
        // TODO(Delight): Add ingredients handling
        ingredients: [],
      );

      ref.read(userRecipesControllerProvider.notifier).createRecipe(request);
    } else {
      form.markAllAsTouched();
    }
  }

  Widget _buildTimeInputRow(
    String label,
    String hoursControlName,
    String minutesControlName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ReactiveTextField<int>(
                formControlName: hoursControlName,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
                validationMessages: {
                  ValidationMessage.min: (error) => 'Hours must be 0 or greater',
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ReactiveTextField<int>(
                formControlName: minutesControlName,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Minutes',
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
                validationMessages: {
                  ValidationMessage.min: (error) => 'Minutes must be 0 or greater',
                  ValidationMessage.max: (error) => 'Minutes must be less than 60',
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userRecipesControllerProvider, (_, next) {
      if (true == next.isCreated) {
        Navigator.of(context).pop();
      }
    });

    return CustomScaffold(
      title: 'Create Recipe',
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
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
              const SizedBox(height: 24),

              // Prep Time
              _buildTimeInputRow(
                'Prep Time',
                'prepHours',
                'prepMinutes',
              ),
              const SizedBox(height: 24),

              // Cook Time
              _buildTimeInputRow(
                'Cook Time',
                'cookHours',
                'cookMinutes',
              ),
              const SizedBox(height: 16),

              // Instructions
              ReactiveTextField<String>(
                formControlName: 'instructions',
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                  border: OutlineInputBorder(),
                  hintText: 'Enter cooking instructions (optional)',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: form.valid ? _submitForm : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Create Recipe',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
