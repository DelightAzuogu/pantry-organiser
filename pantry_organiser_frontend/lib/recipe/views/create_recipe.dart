import 'package:flutter/material.dart';
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
  List<AddRecipeIngredientRequest> ingredients = [];

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
        ingredients: ingredients,
      );

      ref.read(userRecipesControllerProvider.notifier).createRecipe(request);
    } else {
      form.markAllAsTouched();
    }
  }

  void _addIngredient(AddRecipeIngredientRequest ingredient) {
    setState(() {
      ingredients.add(ingredient);
    });
  }

  void _updateIngredient(int index, AddRecipeIngredientRequest ingredient) {
    setState(() {
      ingredients[index] = ingredient;
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const RecipeBasicInfoSection(),
                    const SizedBox(height: 24),
                    const RecipeTimeInputSection(),
                    const SizedBox(height: 24),
                    RecipeIngredientsSection(
                      ingredients: ingredients,
                      onAddIngredient: _addIngredient,
                      onUpdateIngredient: _updateIngredient,
                      onRemoveIngredient: _removeIngredient,
                    ),
                    const SizedBox(height: 24),
                    const RecipeInstructionsSection(),
                  ],
                ),
              ),
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: form.valid ? _submitForm : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Create Recipe',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
