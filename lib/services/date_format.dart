import 'package:intl/intl.dart';

String formatDateOfBirth(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Format the date as yyyy-MM-dd
}

// Format the date as MMMM d, yyyy in Arabic locale
String formatEventDate(DateTime date) {
  return DateFormat('MMMM d', 'ar').format(date);
}