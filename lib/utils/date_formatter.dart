import 'package:intl/intl.dart';

class DateFormatter {
  static String format(String isoString) {
    final date = DateTime.parse(isoString);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
