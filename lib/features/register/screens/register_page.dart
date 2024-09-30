import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/features/register/providers/register_provider.dart';
import 'package:just_tickets/features/register/widgets/register_button.dart';
import 'dart:ui' as ui;


class RegisterPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state providers for each field
    final firstNameController = ref.watch(firstNameControllerProvider);
    final lastNameController = ref.watch(lastNameControllerProvider);
    final dateController = ref.watch(dateTextControllerProvider);  // Controller for the date field
    final emailController = ref.watch(emailControllerProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when the user taps outside the text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
                resizeToAvoidBottomInset: false, // Prevents resizing the background image

        body: Stack(
          children: [
            SvgPicture.asset(
              Assets.jtBackgroundImage,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
                   Positioned(
              right: 0,
              left: 0,
              top: height * 0.1,
              child: Image.asset(
                Assets.justTicketsLogo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First Name TextFormField
                    TextFormField(
                      textDirection: ui.TextDirection.rtl,
      
                      controller: firstNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'الاسم الاول',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Last Name TextFormField
                    TextFormField(
      textDirection: ui.TextDirection.rtl,
                      controller: lastNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'اسم العائلة',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                                 TextFormField(
  keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'الايميل',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                 TextFormField(
                  controller: dateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'تاريخ الميلاد',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                    hintText: 'Select your date of birth',
                  ),
                  readOnly: true,  // Prevent manual text input
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
      
                    if (selectedDate != null) {
                      // Format the selected date and set it in the controller
                      final formattedDate = DateFormat('MMMM d, yyyy').format(selectedDate);
                      ref.read(dateTextControllerProvider).text = formattedDate;  // Update the controller with the formatted date
                    }
                  },
                ),
                    const SizedBox(height: 32),
      
                    // Register Button
                    const RegisterButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
