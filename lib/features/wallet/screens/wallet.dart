import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_tickets/features/wallet/screens/active_tickets.dart';

class WalletPage extends HookWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a TabController using Flutter Hooks
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المحفظة',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.purple,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Active Tickets'),
            Tab(text: 'Used Tickets'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ActiveTicketsPage(), // Active Tickets placeholder page
          UsedTicketsPage(),   // Used Tickets placeholder page
        ],
      ),
    );
  }
}



// Placeholder for Used Tickets page
class UsedTicketsPage extends StatelessWidget {
  const UsedTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Used Tickets'),
    );
  }
}
