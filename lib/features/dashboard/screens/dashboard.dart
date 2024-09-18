import 'package:flutter/material.dart';
import 'package:just_tickets/features/dashboard/widgets/custom_app_bar.dart';
import '../widgets/circle_filter.dart'; // Import the reusable CircleFilter widget
import 'package:just_tickets/constants/assets.dart'; // Assuming icons are stored in Assets class

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Use the custom AppBar here
      body: Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}
