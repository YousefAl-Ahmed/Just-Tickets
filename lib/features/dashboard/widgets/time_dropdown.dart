import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_tickets/constants/assets.dart';

class TimeDropdown extends StatefulWidget {
  const TimeDropdown({Key? key}) : super(key: key);

  @override
  _TimeDropdownState createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
  String _selectedTime = 'اليوم'; // Default value

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7030A0).withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 12,
          ),
        ],
      ),
      child: DropdownButton<String>(
        // center text

        // isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        value: _selectedTime,
        items: [
          DropdownMenuItem(
              value: 'اليوم',
              child:
                  Text('اليوم', style: Theme.of(context).textTheme.titleSmall)),
          DropdownMenuItem(
              value: 'غدا',
              child:
                  Text('غدا', style: Theme.of(context).textTheme.titleSmall)),
          DropdownMenuItem(
              value: 'هذا الاسبوع',
              child: Text('هذا الاسبوع',
                  style: Theme.of(context).textTheme.titleSmall)),
        ],
        onChanged: (value) {
          setState(() {
            _selectedTime = value!;
          });
          print("Selected time filter: $_selectedTime");
        },
        underline: SizedBox(), // Remove underline
        icon: SvgPicture.asset(
          Assets.downArrow,
        ),
      ),
    );
  }
}
