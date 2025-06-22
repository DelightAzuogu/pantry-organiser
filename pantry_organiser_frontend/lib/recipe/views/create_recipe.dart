import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/recipe/recipe.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateRecipe extends ConsumerStatefulWidget {
  const CreateRecipe({
    this.isEditing = false,
    super.key,
  });

  final bool isEditing;

  @override
  ConsumerState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends ConsumerState<CreateRecipe> {
  late FormGroup form;
  List<AddRecipeIngredientRequest> ingredients = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm([RecipeDetailsModel? recipe]) {
    form = FormGroup({
      'name': FormControl<String>(
        value: recipe?.name,
        validators: [Validators.required],
      ),
      'description': FormControl<String>(
        value: recipe?.description,
      ),
      'instructions': FormControl<String>(
        value: recipe?.instructions,
      ),
      'servingSize': FormControl<int>(
        value: recipe?.servingSize,
        validators: [
          Validators.required,
          Validators.min(1),
        ],
      ),
      'prepHours': FormControl<int>(
        value: recipe?.prepTime.inHours ?? 0,
        validators: [Validators.min(0)],
      ),
      'prepMinutes': FormControl<int>(
        value: recipe != null ? (recipe.prepTime.inMinutes) % 60 : 0,
        validators: [
          Validators.min(0),
          Validators.max(59),
        ],
      ),
      'cookHours': FormControl<int>(
        value: recipe?.cookTime.inHours ?? 0,
        validators: [Validators.min(0)],
      ),
      'cookMinutes': FormControl<int>(
        value: recipe != null ? (recipe.cookTime.inMinutes) % 60 : 0,
        validators: [
          Validators.min(0),
          Validators.max(59),
        ],
      ),
    });

    // Initialize ingredients if editing
    if (recipe != null) {
      ingredients = recipe.ingredients.map((ingredient) {
        return AddRecipeIngredientRequest(
          id: ingredient.id,
          name: ingredient.name,
          quantity: ingredient.quantity,
          quantityUnit: ingredient.quantityUnit,
          recipeId: recipe.id,
        );
      }).toList();
    }
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (form.valid) {
      final formValue = form.value;

      if (widget.isEditing) {
        final selectedRecipe = ref.read(selectedRecipeProvider);
        if (selectedRecipe != null) {
          final updateRequest = AddRecipeRequest(
            name: formValue['name']! as String,
            description: true == (formValue['description'] as String?)?.isNotEmpty ? formValue['description'] as String? : null,
            instructions: true == (formValue['instructions'] as String?)?.isNotEmpty ? formValue['instructions'] as String? : null,
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

          await ref.read(userRecipesControllerProvider.notifier).updateRecipe(
                updateRequest,
                selectedRecipe.id,
              );
        }
      } else {
        final request = AddRecipeRequest(
          name: formValue['name']! as String,
          description: true == (formValue['description'] as String?)?.isNotEmpty ? formValue['description'] as String? : null,
          instructions: true == (formValue['instructions'] as String?)?.isNotEmpty ? formValue['instructions'] as String? : null,
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

        await ref
            .read(
              userRecipesControllerProvider.notifier,
            )
            .createRecipe(
              request,
            );
      }
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
    final selectedRecipe = ref.watch(selectedRecipeProvider);

    // Initialize form with recipe data when editing
    if (widget.isEditing && selectedRecipe != null && !_isInitialized) {
      _initializeForm(selectedRecipe);
      _isInitialized = true;
    }

    ref.listen(userRecipesControllerProvider, (_, next) async {
      if (widget.isEditing) {
        if (true == next.isUpdated) {
          ref.invalidate(getRecipeDetailsProvider);
          await showCustomToast(message: 'Recipe updated successfully');
          Navigator.of(context).pop();
        }
      } else {
        if (true == next.isCreated) {
          await showCustomToast(
            message: 'Recipe created successfully',
          );
          Navigator.of(context).pop();
        }
      }
    });

    return CustomScaffold(
      title: widget.isEditing ? 'Edit Recipe' : 'Create Recipe',
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
                    child: AsyncButton(
                      onPressed: form.valid ? _submitForm : null,
                      child: Text(
                        widget.isEditing ? 'Update Recipe' : 'Create Recipe',
                        style: const TextStyle(fontSize: 16),
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
