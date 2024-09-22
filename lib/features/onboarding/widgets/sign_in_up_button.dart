
import 'package:flutter/material.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/features/login/screens/login.dart';


class SignInSignUpButton extends StatelessWidget {
  const SignInSignUpButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage(),),);

      },
      child: Container(
        width: width,
        height: 50,
      
        decoration: BoxDecoration(
          color: CustomColors.orange,
          borderRadius: BorderRadius.circular(12),
        ),  
        child:  Center(
          child: Text(
            'تسجيل دخول/ انشاء حساب',
            style:       theme.textTheme.labelMedium
    
            
          ),
        ),
      ),
    );
  }
}
