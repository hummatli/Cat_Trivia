import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  //Formats date using the full month name, day of the month, year, hour, minutes
  // (e.g., April 1, 2023 9:20 AM) according to the current device locale.
  String formatDate() {
    return "${DateFormat.yMMMMd().format(this)} ${DateFormat.jm().format(this)}";
  }
}
