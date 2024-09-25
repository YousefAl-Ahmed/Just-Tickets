import 'package:intl/intl.dart';

String formatDateOfBirth(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Format the date as yyyy-MM-dd
}
