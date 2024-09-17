
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/login/providers/login_providers.dart';

class MobileTextField extends ConsumerWidget {
  const MobileTextField({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final phoneController = ref.watch(phoneControllerProvider); // Get the controller from the provider

    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'رقم الهاتف',
          labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.phone, color: Colors.white),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
