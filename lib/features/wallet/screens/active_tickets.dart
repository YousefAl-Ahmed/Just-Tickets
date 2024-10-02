import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/wallet/provider/wallet_tickets_provider.dart';
import 'package:just_tickets/features/wallet/widgets/ticket_card.dart';

class ActiveTicketsPage extends ConsumerWidget {
  const ActiveTicketsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current user from the authStateNotifierProvider
    final user = ref.watch(authStateNotifierProvider);

    // Handle null UID and display a message if the user is not logged in
    if (user?.uid == null || user!.uid.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Wallet'),
        ),
        body: const Center(
          child: Text('You need to log in to view your wallet.'),
        ),
      );
    }

    // Fetch the user's tickets using the provider
    final userTickets = ref.watch(userTicketsProvider(user.uid));

    // Function to refresh the ticket list
    Future<void> _refreshTickets() async {
      // Invalidate the userTicketsProvider to force a re-fetch of the tickets
      ref.refresh(userTicketsProvider(user.uid));
    }

    return Scaffold(
  
      body: RefreshIndicator(
        onRefresh: _refreshTickets, // Trigger refresh on swipe down
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Always allow scroll
          child: SizedBox(
            height: MediaQuery.of(context).size.height, // Take full page height
            child: userTickets.when(
              data: (tickets) {
                if (tickets.isEmpty) {
                  return const Center(
                    child: Text('No tickets found in your wallet'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true, // Prevent taking full screen height
                  physics: const NeverScrollableScrollPhysics(), // Disable internal scroll
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return TicketCard(ticket: ticket); // Reusable TicketCard widget
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            ),
          ),
        ),
      ),
    );
  }
}