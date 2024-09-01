
  import 'package:flutter/material.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/home_base.dart';

class EnterGuestButton extends StatelessWidget {
  const EnterGuestButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeBase()));
      },
      child: Container(
        width: width,
        height: 50,
      
        decoration: BoxDecoration(
          color: CustomColors.purple,
          borderRadius: BorderRadius.circular(12),
        ),  
        child:  Center(
          child: Text(
            'تصفح التطبيق',
            style: theme.textTheme.labelMedium
            ),
          ),
        ),
      );
  }
}
