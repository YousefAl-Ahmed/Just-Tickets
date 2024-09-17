import 'package:flutter/material.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/features/onboarding/widgets/enter_guest_button.dart';
import 'package:just_tickets/features/onboarding/widgets/sign_in_up_button.dart';
import 'package:just_tickets/home_base.dart';

import '../widgets/welcome_page_buttons.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      
      body: Stack(
        children: [          
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:  AssetImage(Assets.welcomePage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(right: 0, left: 0, top: height *0.1, child: Image.asset(Assets.justTicketsLogo),),
           const WelcomePageButtons(),
          

   
        ],
      ),
    );
  
  }
}
