import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pantry_organiser_frontend/api/api.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/pantry_item/pantry_item.dart';

class PantryItemCard extends ConsumerWidget {
  const PantryItemCard({
    required this.item,
    super.key,
  });

  final PantryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expiryColor = _getExpiryColor(item.expiryDate);
    final expiryText = item.expiryDate != null ? DateHelper.formatRelativeDate(item.expiryDate!) : 'No expiry date';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ref.read(selectedPantryItemProvider.notifier).state = item;
          Navigator.pushNamed(context, '/addPantryItem');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.expiryDate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: expiryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getExpiryIcon(item.expiryDate!),
                      color: Colors.white,
                      size: 18,
                    ),
                    const Gap(8),
                    Text(
                      expiryText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (item.brand != null) ...[
                              const Gap(4),
                              Text(
                                item.brand!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${item.quantity} ${item.quantityUnit.shortForm}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                  if (item.description != null) ...[
                    const Gap(12),
                    Text(
                      item.description!,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getExpiryColor(DateTime? expiryDate) {
    if (expiryDate == null) return Colors.grey;

    final now = DateTime.now();
    final daysLeft = expiryDate.difference(now).inDays;

    if (daysLeft < 0) return Colors.red[700] ?? Colors.red; // Expired
    if (daysLeft <= 3) return Colors.orange[700] ?? Colors.orange; // Expiring soon
    return Colors.green[600] ?? Colors.green; // Safe
  }

  IconData _getExpiryIcon(DateTime expiryDate) {
    final now = DateTime.now();
    final daysLeft = expiryDate.difference(now).inDays;

    if (daysLeft < 0) return Icons.warning_rounded;
    if (daysLeft <= 3) return Icons.access_time_rounded;
    return Icons.check_circle_rounded;
  }
}
