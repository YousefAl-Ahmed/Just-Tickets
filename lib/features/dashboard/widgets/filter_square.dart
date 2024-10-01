import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterSquare extends StatelessWidget {
  final String label;
  final String? leftIcon; // Optional: Path for the left SVG icon
  final String? rightIcon; // Optional: Path for the right SVG icon
  final VoidCallback onTap;

  const FilterSquare({
    Key? key,
    required this.label,
    this.leftIcon, // Allow null if there's no icon
    this.rightIcon, // Allow null if there's no icon
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7030A0).withOpacity(0.25), // Shadow color
              offset: const Offset(0, 2),
              blurRadius: 12,
            ),
          ],
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (rightIcon != null) ...[
                const SizedBox(width: 5),
                SvgPicture.asset(rightIcon!),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(label, style: Theme.of(context).textTheme.titleSmall
                    //  style: Theme.of(context).textTheme.bodyLarge
                    ),
              ),
              if (leftIcon != null) ...[
                SvgPicture.asset(
                  leftIcon!,
                ),
                const SizedBox(width: 5),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
