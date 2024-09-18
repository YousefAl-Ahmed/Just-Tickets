import 'package:flutter/material.dart';

class CircleFilter extends StatelessWidget {
  final String iconAsset; // The path to the icon asset
  final String label; // The text label under the circle

  const CircleFilter({
    Key? key,
    required this.iconAsset,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7030A0), // Top color
                Color(0xFF8360E5), // Bottom color
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x707060E5)
                    .withOpacity(0.45), // Shadow color with opacity
                offset: Offset(0, 2), // X: 0, Y: 2
                blurRadius: 10, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              iconAsset, // The icon inside the circle
              width: 24, // Adjust icon size if needed
              height: 24,
              color: Colors.white, // Ensure the icon color fits the design
            ),
          ),
        ),
        const SizedBox(height: 8), // Space between circle and text
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.black, // Text color
                fontWeight: FontWeight.bold, // Adjust weight if needed
              ),
          textAlign: TextAlign.center, // Ensure RTL is handled
        ),
      ],
    );
  }
}
