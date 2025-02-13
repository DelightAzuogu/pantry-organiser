import 'package:intl/intl.dart';

class DateHelper {
  /// Returns a human-readable time difference.
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inSeconds.abs() < 60) {
      return 'just now';
    } else if (difference.inMinutes.abs() < 60) {
      return "${difference.inMinutes.abs()} minute${difference.inMinutes.abs() == 1 ? '' : 's'} ${difference.isNegative ? 'ago' : 'from now'}";
    } else if (difference.inHours.abs() < 24) {
      return "${difference.inHours.abs()} hour${difference.inHours.abs() == 1 ? '' : 's'} ${difference.isNegative ? 'ago' : 'from now'}";
    } else if (difference.inDays.abs() < 7) {
      return "${difference.inDays.abs()} day${difference.inDays.abs() == 1 ? '' : 's'} ${difference.isNegative ? 'ago' : 'from now'}";
    } else if (date.year == now.year) {
      return DateFormat('d MMM').format(date); // Example: "10 Jan"
    } else {
      return DateFormat('d MMM yyyy').format(date); // Example: "10 Jan 2024"
    }
  }
}
