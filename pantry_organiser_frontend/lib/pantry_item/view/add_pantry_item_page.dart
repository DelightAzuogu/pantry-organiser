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
  }

  Future<void> _onSubmit() async {
    final createPantryItemRequest = CreatePantryItemRequest(
      name: form.control('name').value! as String,
      description: form.control('description').value as String?,
      quantity: form.control('quantity').value! as double,
      quantityUnit: form.control('quantityUnit').value! as QuantityUnit,
      brand: form.control('brand').value as String?,
      expiryDate: form.control('expiryDate').value as DateTime?,
    );

    final pantryId = ref.read(selectedPantryProvider)!.id;

    await ref.read(pantryItemControllerProvider.notifier).createPantryItem(
          request: createPantryItemRequest,
          pantryId: pantryId,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      pantryItemControllerProvider,
      (prev, next) {
        // TODO(Delight): handle the remaining states changes when it comes to those
        if (next.isCreated) {
          Navigator.pop(context);
          ref.invalidate(getPantryItemsProvider);
        } else if (next.error != null) {
          showCustomToast(message: 'Error creating the pantry item');
        }
      },
    );

    return CustomScaffold(
      title: 'Add Pantry Item',
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
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Add Item'),
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
