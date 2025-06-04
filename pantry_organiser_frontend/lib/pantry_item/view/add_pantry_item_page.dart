import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/custom_toast.dart';
import 'package:pantry_organiser_frontend/pantry/pantry.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddPantryItemPage extends ConsumerStatefulWidget {
  const AddPantryItemPage({super.key});

  @override
  ConsumerState createState() => _AddPantryItemPageState();
}

class _AddPantryItemPageState extends ConsumerState<AddPantryItemPage> {
  late final FormGroup form;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(
        validators: [Validators.required],
      ),
      'description': FormControl<String>(),
      'quantity': FormControl<double>(
        validators: [Validators.required, Validators.min(0)],
      ),
      'quantityUnit': FormControl<QuantityUnit>(
        validators: [Validators.required],
      ),
      'brand': FormControl<String>(),
      'expiryDate': FormControl<DateTime>(),
    });

    // Get the selected pantry item and pre-fill the form if it exists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedPantryItem = ref.read(selectedPantryItemProvider);
      if (selectedPantryItem != null) {
        isEditing = true;
        form.patchValue({
          'name': selectedPantryItem.name,
          'description': selectedPantryItem.description,
          'quantity': selectedPantryItem.quantity,
          'quantityUnit': selectedPantryItem.quantityUnit,
          'brand': selectedPantryItem.brand,
          'expiryDate': selectedPantryItem.expiryDate,
        });
      }
    });
  }

  Future<void> _onSubmit() async {
    final request = CreatePantryItemRequest(
      name: form.control('name').value! as String,
      description: form.control('description').value as String?,
      quantity: form.control('quantity').value! as double,
      quantityUnit: form.control('quantityUnit').value! as QuantityUnit,
      brand: form.control('brand').value as String?,
      expiryDate: form.control('expiryDate').value as DateTime?,
    );

    final selectedPantryItem = ref.read(selectedPantryItemProvider);

    if (isEditing && selectedPantryItem != null) {
      // If editing, call update method
      await ref.read(pantryItemControllerProvider.notifier).updatePantryItem(
            request: request,
            itemId: selectedPantryItem.id,
          );
    } else {
      // If creating new, call create method
      final pantryId = ref.read(selectedPantryProvider)!.id;
      await ref.read(pantryItemControllerProvider.notifier).createPantryItem(
            request: request,
            pantryId: pantryId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      pantryItemControllerProvider,
      (prev, next) {
        if (next.isCreated || next.isUpdated) {
          ref.invalidate(getPantryItemsProvider);
          if (isEditing) {
            ref.read(selectedPantryItemProvider.notifier).state = null;
          }
          Navigator.pop(context);
        } else if (next.error != null) {
          showCustomToast(message: isEditing ? 'Error updating the pantry item' : 'Error creating the pantry item');
        }
      },
    );

    return CustomScaffold(
      title: isEditing ? 'Edit Pantry Item' : 'Add Pantry Item',
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReactiveTextField<String>(
                        formControlName: 'name',
                        decoration: const InputDecoration(
                          labelText: 'Name*',
                          border: OutlineInputBorder(),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) => 'Name is required',
                        },
                      ),
                      const Gap(16),
                      ReactiveTextField<String>(
                        formControlName: 'description',
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 10,
                      ),
                      const Gap(16),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ReactiveTextField<double>(
                                formControlName: 'quantity',
                                decoration: const InputDecoration(
                                  labelText: 'Quantity*',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validationMessages: {
                                  ValidationMessage.required: (_) => 'Quantity is required',
                                  ValidationMessage.min: (_) => 'Quantity must be positive',
                                },
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: ReactiveDropdownField<QuantityUnit>(
                                formControlName: 'quantityUnit',
                                decoration: const InputDecoration(
                                  labelText: 'Unit*',
                                  border: OutlineInputBorder(),
                                ),
                                items: QuantityUnit.values.map((unit) {
                                  return DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit.name),
                                  );
                                }).toList(),
                                validationMessages: {
                                  ValidationMessage.required: (_) => 'Unit is required',
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      ReactiveTextField<String>(
                        formControlName: 'brand',
                        decoration: const InputDecoration(
                          labelText: 'Brand',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Gap(16),
                      ReactiveDatePicker<DateTime>(
                        formControlName: 'expiryDate',
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (context, picker, child) {
                          return ReactiveTextField(
                            formControlName: 'expiryDate',
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  picker.showPicker();
                                },
                              ),
                            ),
                            valueAccessor: DateTimeValueAccessor(
                              dateTimeFormat: DateFormat('yyyy-MM-dd'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return AsyncButton(
                      width: double.infinity,
                      onPressed: form.valid ? _onSubmit : null,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(isEditing ? 'Update Item' : 'Add Item'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}
