import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/ticket.dart';
import 'package:just_tickets/constants/colors.dart';
import 'package:just_tickets/features/dashboard/provider/events_provider.dart';
import 'package:just_tickets/services/date_format.dart';

class TicketCard extends ConsumerWidget {
  final Ticket ticket;

  const TicketCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the eventId to fetch the event details
    final eventAsyncValue = ref.watch(eventByIdProvider(ticket.eventId));

    return Container(
      margin: const EdgeInsets.all(16.0),
      width: 350,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xB37030A0), // Color with 70% opacity
            offset: Offset(0, 0),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          // Ticket Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                                        Text(eventAsyncValue.when(
                          data: (event) {
                            if (event != null) {
                              return event.title;
                            } else {
                              return '';
                            }
                          },
                          loading: () => '',
                          error: (error, stackTrace) => '',
                        )),
                 Center(child: Text(ticket.ticketId, style: const TextStyle(color: CustomColors.grey),)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(eventAsyncValue.when(
                          data: (event) {
                            if (event != null) {
                              return formatEventDate(event.startTime);
                            } else {
                              return '';
                            }
                          },
                          loading: () => '',
                          error: (error, stackTrace) => '',
                        )),
                                    Text(eventAsyncValue.when(
                          data: (event) {
                            if (event != null) {
                              return event.locationName;
                            } else {
                              return '';
                            }
                          },
                          loading: () => '',
                          error: (error, stackTrace) => '',
                        )),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Event Image
          eventAsyncValue.when(
            data: (event) {
              if (event != null ) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.network(
                      event.imagesUrl[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(child: Text('')),
                );
              }
            },
            loading: () => const SizedBox(
              width: 150,
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => const SizedBox(
              width: 150,
              height: 150,
              child: Center(child: Text('Error loading image')),
            ),
          ),
        ],
      ),
    );
  }
}
