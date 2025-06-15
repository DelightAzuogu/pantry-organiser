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

  void _showAddIngredientDialog([int? editIndex]) {
    final isEditing = editIndex != null;
    final existingIngredient = isEditing ? ingredients[editIndex] : null;

    final ingredientForm = FormGroup({
      'name': FormControl<String>(
        value: existingIngredient?.name,
        validators: [Validators.required],
      ),
      'quantity': FormControl<double>(
        value: existingIngredient?.quantity,
        validators: [
          Validators.required,
          Validators.min(0.01),
        ],
      ),
      'quantityUnit': FormControl<QuantityUnit>(
        value: existingIngredient?.quantityUnit,
        validators: [Validators.required],
      ),
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Ingredient' : 'Add Ingredient'),
        content: ReactiveForm(
          formGroup: ingredientForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: const InputDecoration(
                  labelText: 'Ingredient Name *',
                  border: OutlineInputBorder(),
                  hintText: 'Enter ingredient name',
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Ingredient name is required',
                },
              ),
              const SizedBox(height: 16),
              ReactiveTextField<double>(
                formControlName: 'quantity',
                decoration: const InputDecoration(
                  labelText: 'Quantity *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Quantity is required',
                  ValidationMessage.min: (_) => 'Quantity must be positive',
                },
              ),
              const SizedBox(width: 16),
              ReactiveDropdownField<QuantityUnit>(
                formControlName: 'quantityUnit',
                decoration: const InputDecoration(
                  labelText: 'Unit *',
                  border: OutlineInputBorder(),
                ),
                items: QuantityUnit.values.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text('${unit.name} (${unit.shortForm})'),
                  );
                }).toList(),
                validationMessages: {
                  ValidationMessage.required: (_) => 'Unit is required',
                },
              ),
              const SizedBox(height: 16),
              // Move ReactiveFormConsumer inside the ReactiveForm
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: form.valid
                            ? () {
                                final formValue = ingredientForm.value;
                                final ingredient = AddRecipeIngredientRequest(
                                  name: formValue['name']! as String,
                                  quantity: formValue['quantity']! as double,
                                  quantityUnit: formValue['quantityUnit']! as QuantityUnit,
                                );

                                setState(() {
                                  if (isEditing) {
                                    ingredients[editIndex] = ingredient;
                                  } else {
                                    ingredients.add(ingredient);
                                  }
                                });

                                Navigator.of(context).pop();
                              }
                            : null,
                        child: Text(isEditing ? 'Update' : 'Add'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        actions: [],
      ),
    ).then((_) {
      ingredientForm.dispose();
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddIngredientDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Add Ingredient'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (ingredients.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8),
                Text(
                  'No ingredients added yet',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap "Add Ingredient" to get started',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        else
          ...ingredients.asMap().entries.map((entry) {
            final index = entry.key;
            final ingredient = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  ingredient.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '${ingredient.quantity} ${ingredient.quantityUnit.shortForm}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _showAddIngredientDialog(index),
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit ingredient',
                    ),
                    IconButton(
                      onPressed: () => _removeIngredient(index),
                      icon: const Icon(Icons.close),
                      tooltip: 'Remove ingredient',
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
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
              const SizedBox(height: 24),

              // Ingredients Section
              _buildIngredientsSection(),
              const SizedBox(height: 24),

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
