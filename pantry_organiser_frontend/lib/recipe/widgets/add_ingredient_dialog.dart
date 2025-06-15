import 'package:flutter/material.dart';
import 'package:pantry_organiser_frontend/api/api.dart';

class AddIngredientDialog extends StatefulWidget {
  const AddIngredientDialog({
    required this.onSubmit,
    super.key,
    this.existingIngredient,
  });

  final AddRecipeIngredientRequest? existingIngredient;
  final Function(AddRecipeIngredientRequest) onSubmit;

  @override
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  QuantityUnit? _selectedUnit;

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingIngredient?.name ?? '');
    _quantityController = TextEditingController(
      text: widget.existingIngredient?.quantity?.toString() ?? '',
    );
    _selectedUnit = widget.existingIngredient?.quantityUnit;

    _nameController.addListener(_validateForm);
    _quantityController.addListener(_validateForm);
  }

  void _validateForm() {
    final isNameValid = _nameController.text.trim().isNotEmpty;
    final quantity = double.tryParse(_quantityController.text.trim()) ?? 0;
    final isQuantityValid = quantity > 0;
    final isUnitValid = _selectedUnit != null;

    final valid = isNameValid && isQuantityValid && isUnitValid;

    if (valid != _isFormValid) {
      setState(() {
        _isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submitIngredient() {
    if (_formKey.currentState!.validate()) {
      final ingredient = AddRecipeIngredientRequest(
        name: _nameController.text.trim(),
        quantity: double.tryParse(_quantityController.text.trim()) ?? 0,
        quantityUnit: _selectedUnit!,
      );

      widget.onSubmit(ingredient);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingIngredient != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Ingredient' : 'Add Ingredient'),
      content: SizedBox(
        width: 600, // 👈 wider dialog for desktop
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ingredient Name *',
                    border: OutlineInputBorder(),
                    hintText: 'Enter ingredient name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingredient name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    final quantity = double.tryParse(value ?? '');
                    if (quantity == null || quantity <= 0) {
                      return 'Quantity must be positive';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<QuantityUnit>(
                  value: _selectedUnit,
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
                  onChanged: (unit) {
                    setState(() {
                      _selectedUnit = unit;
                      _validateForm();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Unit is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isFormValid ? _submitIngredient : null,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
