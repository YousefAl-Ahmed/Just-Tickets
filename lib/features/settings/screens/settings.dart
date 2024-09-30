import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    final user = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),

              // Profile Section
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Assets.profilePic),
              ),
              const SizedBox(height: 16),
              Text(
                user != null ? '${user.firstName} ${user.lastName}' : '',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 32),

              // Container with shadow and sections
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Account Section
                    const Text(
                      'الحساب',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Personal Information Button
                    TextButton(
                      onPressed: () {
                        // Navigate to Personal Information Page
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 8),
                          Text('المعلومات الشخصية'),
                        ],
                      ),
                    ),
                    // Bills Button
                    TextButton(
                      onPressed: () {
                        // Navigate to Bills Page
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.receipt),
                          SizedBox(width: 8),
                          Text('الفواتير'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // App Preferences Section
                    const Text(
                      'تفضيلات التطبيق',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Languages Button
                    TextButton(
                      onPressed: () {
                        // Navigate to Languages Page
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.language),
                          SizedBox(width: 8),
                          Text('اللغات'),
                        ],
                      ),
                    ),
                    // Dark Mode Button
                    TextButton(
                      onPressed: () {
                        // Toggle Dark Mode
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.dark_mode),
                          SizedBox(width: 8),
                          Text('الوضع الليلي'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Help Section
                    const Text(
                      'المساعدة',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Contact Us Button
                    TextButton(
                      onPressed: () {
                        // Open Contact Us Page
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.contact_mail),
                          SizedBox(width: 8),
                          Text('تواصل معنا'),
                        ],
                      ),
                    ),
                    // Rate Us Button
                    TextButton(
                      onPressed: () {
                        // Open Rate Us Page
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.star_rate),
                          SizedBox(width: 8),
                          Text('قيمنا'),
                        ],
                      ),
                    ),
                    // Share App Button
                    TextButton(
                      onPressed: () {
                        // Share the app
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text('شارك التطبيق'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
