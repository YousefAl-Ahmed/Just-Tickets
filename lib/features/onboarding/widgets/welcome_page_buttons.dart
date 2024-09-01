
import 'package:flutter/material.dart';

import 'enter_guest_button.dart';
import 'sign_in_up_button.dart';

class WelcomePageButtons extends StatelessWidget {
  const WelcomePageButtons({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
     padding: const EdgeInsets.all(24.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         Text(
           'احجز واستمتع',
           style: theme.textTheme.titleLarge,
         ),
         const SizedBox(height: 32),
          const SignInSignUpButton(),
         const SizedBox(height: 24),
         const EnterGuestButton(),
         const SizedBox(height: 54),
       ],
     ),
              );
  }
}
