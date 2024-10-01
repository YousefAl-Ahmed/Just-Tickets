import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleFilter extends StatelessWidget {
  final String iconAsset; // The path to the icon asset
  final String label; // The text label under the circle
  final VoidCallback onTap; // The callback function for tap

  const CircleFilter({
    Key? key,
    required this.iconAsset,
    required this.label,
    required this.onTap, // Add the onTap parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Set the onTap callback
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                child: SvgPicture.asset(
                  iconAsset, // Use SVG for the notification icon
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between circle and text
            SizedBox(
              width: 80,
              height: 40, // Width of the text container
              child: Text(
                label,
                textWidthBasis: TextWidthBasis.parent,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center, // Ensure RTL is handled
              ),
            ),
          ],
        ),
      ),
    );
  }
}
