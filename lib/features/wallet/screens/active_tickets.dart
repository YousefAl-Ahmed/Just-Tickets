import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/wallet/provider/wallet_tickets_provider.dart';
import 'package:just_tickets/features/wallet/widgets/nfc_reader.dart';
import 'package:just_tickets/features/wallet/widgets/ticket_swiper.dart';
import 'package:just_tickets/classes/ticket.dart';

class ActiveTicketsPage extends ConsumerWidget {
  const ActiveTicketsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider);

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

    final userTickets = ref.watch(userTicketsProvider(user.uid));

    Future<void> _refreshTickets() async {
      ref.refresh(userTicketsProvider(user.uid));
    }

    return Scaffold(
      // appBar: AppBar(title: const Text('My Wallet')),
      body: RefreshIndicator(
        onRefresh: _refreshTickets,
        child: userTickets.when(
          data: (tickets) {
            if (tickets.isEmpty) {
              return const Center(
                child: Text('لا يوجد اي تذاكر في المحفظة'),
              );
            }
            return Column(
              children: [
                Image.asset(Assets.wallet_card), // Wallet banner image
                TicketSwiper(
                  tickets: tickets,
                  onTicketSelected: (ticket) {
                    print('Selected Ticket: ${ticket.ticketId}');
                    // Handle NFC or other actions.

                    // Navigate to NFCReader page with the selected ticket
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NFCReader(selectedTicket: ticket),
                      ),
                    );
                  },
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
