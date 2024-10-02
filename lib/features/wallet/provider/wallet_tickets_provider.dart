import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/ticket.dart';
import 'package:just_tickets/core/backend/ticket_service.dart';

// Ticket service provider
final ticketServiceProvider = Provider<TicketService>((ref) {
  return TicketService();
});

// Provider to fetch user tickets
final userTicketsProvider = FutureProvider.family<List<Ticket>, String>((ref, userId) async {
  final ticketService = ref.read(ticketServiceProvider);
  return await ticketService.fetchUserTickets(userId);
});


// TabControllerNotifier that holds the index of the current tab
class TabControllerNotifier extends StateNotifier<int> {
  TabControllerNotifier() : super(0); // Initialize with the first tab (index 0)

  // Method to update the selected tab index
  void updateTab(int index) {
    state = index;
  }
}

// StateNotifierProvider for the TabControllerNotifier
final tabControllerProvider = StateNotifierProvider<TabControllerNotifier, int>(
  (ref) => TabControllerNotifier(),
);
