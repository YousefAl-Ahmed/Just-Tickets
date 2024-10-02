import 'package:intl/intl.dart';

String formatDateOfBirth(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Format the date as yyyy-MM-dd
}

// Format the date as MMMM d, yyyy in Arabic locale
String formatEventDate(DateTime date) {
  return DateFormat('MMMM d').format(date);
}

String formatEventTimeHour(DateTime date) {
  // Format the time using 'h:mm a' format
  final formattedTime = DateFormat('h:mm a').format(date);

  // Split the time into the hour part and the AM/PM part
  final parts = formattedTime.split(' ');
  final time = parts[0];  // This will give you the 'h:mm' part
  final amPm = parts[1];  // This will give you the 'AM' or 'PM'

  // Replace 'AM' with 'صباحاً' and 'PM' with 'مساءً'
  final amPmInArabic = amPm == 'AM' ? 'صباحاً' : 'مساءً';

  // Return time with Arabic AM/PM at the right
  return '$time $amPmInArabic';
}
