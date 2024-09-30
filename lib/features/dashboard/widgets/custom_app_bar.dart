import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final user = ref.watch(authStateNotifierProvider);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      child: Container(
        height: preferredSize.height + 10,
        color: CustomColors.purple,
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              left: -45,
              child: CircleAvatar(
                radius: 85,
                backgroundColor: Color(0xFF884AB7),
              ),
            ),
            const Positioned(
              top: -55,
              left: -60,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xFFAC5BE8),
              ),
            ),
            const Positioned(
              top: -40,
              left: -60,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFC270FF),
              ),
            ),

            // AppBar Content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Profile Picture (Clickable)
                      GestureDetector(
                        onTap: () {
                          // You can later navigate to the profile settings
                          print('Profile Picture clicked');
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(Assets.profilePic),
                        ),
                      ),
                      // User Info (Text)
                       Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 0.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            user == null
                                ? const Text('')
                                :
                                
                            Text(
                              'ياهلا، ${user.firstName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'حياك اشتري تذكرة',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width: 8), // Space between text and profile picture

                      // Profile Picture
                    ],
                  ),
                  SvgPicture.asset(
                    Assets.bell, // Use SVG for the notification icon
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120); // The height of the AppBar
}
