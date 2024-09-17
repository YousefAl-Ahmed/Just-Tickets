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

    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/JTLOGO.svg',
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
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
        ],
      ),
    );
  }
}
