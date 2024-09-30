import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/features/login/widgets/login_button.dart';
import 'package:just_tickets/features/login/widgets/mobile_textfield.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return GestureDetector(
      onTap: () {
        // Unfocuses all input fields when tapping outside
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

            // Add logo at the top
            Positioned(
              right: 0,
              left: 0,
              top: height * 0.1,
              child: Image.asset(
                Assets.justTicketsLogo,
              ),
            ),

            // Mobile number input field and login button
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: height * 0.4, bottom: 16.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Input for mobile number
                    MobileTextField(),
                    SizedBox(height: 50),
                    LoginButton(),
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
