import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:just_tickets/classes/ticket.dart';
import 'package:just_tickets/features/dashboard/provider/events_provider.dart';
import 'package:just_tickets/services/date_format.dart';

class TicketSwiper extends ConsumerWidget {
  final List<Ticket> tickets; // List of tickets to display
  final Function(Ticket)
      onTicketSelected; // Callback for ticket selection (NFC etc.)

  const TicketSwiper({
    Key? key,
    required this.tickets,
    required this.onTicketSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 300, // Total swiper height
      child: Swiper(
        itemCount: tickets.length,
        itemBuilder: (BuildContext context, int index) {
          final ticket = tickets[index];
          // Fetch event details using ticket.eventId
          final eventAsyncValue = ref.watch(eventByIdProvider(ticket.eventId));

          return eventAsyncValue.when(
            data: (event) {
              if (event == null) {
                return const Center(child: Text('Event not found'));
              }
              return _buildTicketCard(context, ticket, event);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text('Error loading event: $error')),
          );
        },
        onIndexChanged: (int index) {
          // Notify when a ticket is selected
          onTicketSelected(tickets[index]);
        },
        layout: SwiperLayout.STACK, // Cards are stacked with offset
        itemWidth: 250, // Width of each card
        itemHeight: 180, // Height of each card
        pagination: const SwiperPagination(), // Add pagination dots
        control: const SwiperControl(), // Add navigation arrows
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, Ticket ticket, dynamic event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xB37030A0),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ticket Class
            Text(
              ticket.ticketClass,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            // Event Title
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Event Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  formatEventDate(event.startTime),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Event Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                Text(
                  event.locationName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
