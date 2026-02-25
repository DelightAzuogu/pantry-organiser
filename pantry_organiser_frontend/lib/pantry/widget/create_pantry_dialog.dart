import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreatePantryDialog extends ConsumerWidget {
  const CreatePantryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createPantryProvider, (previous, next) {
      if (next.isCreated) {
        Navigator.of(context).pop();
        ref.invalidate(getUserPantriesProvider);
      }
    });

    final form = FormGroup({
      'name': FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
    });

    final createPantryController = ref.read(createPantryProvider.notifier);

    return AlertDialog(
      title: const Text('Create New Pantry'),
      content: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReactiveTextField<String>(
              formControlName: 'name',
              decoration: const InputDecoration(
                labelText: 'Pantry Name',
                hintText: 'Enter pantry name',
              ),
              validationMessages: {
                'required': (error) => 'The pantry name must not be empty',
                'minLength': (error) => 'The pantry name must be at least 3 characters',
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    return AsyncButton(
                      onPressed: !formGroup.valid
                          ? null
                          : () async {
                              if (context.mounted) {
                                await createPantryController.createPantry(
                                  formGroup.control('name').value as String,
                                );
                              }
                            },
                      child: const Text('Create'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
