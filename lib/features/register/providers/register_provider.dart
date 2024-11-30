import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers for the controllers
final firstNameControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final lastNameControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

// Provider for the email
final emailControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final passwordControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
final confirmPasswordControllerProvider =
    StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

// Provider for date of birth
// Provider for the date TextEditingController
final dateTextControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
