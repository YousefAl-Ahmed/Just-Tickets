import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/classes/user.dart';
import 'package:just_tickets/core/backend/ticket_service.dart';


final ticketServiceProvider = Provider<TicketService>((ref) {
  return TicketService();
});

final ticketPurchaseProvider = FutureProvider.family<void, TicketPurchaseParams>((ref, params) async {
  final ticketService = ref.read(ticketServiceProvider);
  await ticketService.buyTicket(params.user, params.event, params.ticketClass);
});

class TicketPurchaseParams {
  final UserClass user;
  final Event event;
  final String ticketClass;

  TicketPurchaseParams({
    required this.user,
    required this.event,
    required this.ticketClass,
  });
}
