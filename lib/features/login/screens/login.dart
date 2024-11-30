import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/features/login/widgets/login_button.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/register/providers/register_provider.dart';
import 'package:just_tickets/features/register/screens/register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isPasswordVisible = false; // Password visibility toggle

  @override
  Widget build(BuildContext context) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard on tap
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Allow UI to adjust for keyboard
        body: Stack(
          children: [
            // Background Image
            SvgPicture.asset(
              Assets.jtBackgroundImage,
              fit: BoxFit.cover,
              // width: width,
              // height: height,
            ),
            // Logo
            Positioned(
              right: 0,
              left: 0,
              top: height * 0.1,
              child: Image.asset(
                Assets.justTicketsLogo,
              ),
            ),
            // Login Form
            Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: height * 0.4,
                bottom: 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email Input Field
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'الايميل',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password Input Field with Eye Icon
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'كلمة السر',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Login Button
                    const LoginButton(),
                    const SizedBox(height: 16),
                    // Text for "Don't have an account?"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب؟ ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the registration page
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'انشاء حساب',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
