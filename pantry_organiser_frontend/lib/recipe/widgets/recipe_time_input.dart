import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RecipeTimeInputSection extends StatelessWidget {
  const RecipeTimeInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Prep Time
        _buildTimeInputRow(
          context,
          'Prep Time',
          'prepHours',
          'prepMinutes',
        ),
        const SizedBox(height: 24),

        // Cook Time
        _buildTimeInputRow(
          context,
          'Cook Time',
          'cookHours',
          'cookMinutes',
        ),
      ],
    );
  }

  Widget _buildTimeInputRow(
    BuildContext context,
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
}
