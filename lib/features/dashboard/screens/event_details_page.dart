import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/core/providers/login_register_providers.dart';
import 'package:just_tickets/features/dashboard/provider/tickets_provider.dart';
import 'package:just_tickets/services/date_format.dart';
import '../provider/events_provider.dart';
import 'package:flutter/services.dart';

class EventDetailsPage extends ConsumerWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider); // Get the selected event
        final user = ref.watch(authStateNotifierProvider);
        

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // Extend the image to fit the app bar
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                selectedEvent?.imagesUrl.isNotEmpty ?? false
                    ? selectedEvent!.imagesUrl[0]
                    : '', // Use the first image or a placeholder
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent, // Make the app bar transparent
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Navigate back
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  // Handle favorites action
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Handle share action
                },
              ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.light, // Light icons in status bar
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Event details go here
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Event Title and Date
                    Text(
                      selectedEvent?.title ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 9, 9),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.calendar_today,
                              size: 16, color: Colors.purple),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formatEventDate(selectedEvent?.startTime ?? DateTime.now()),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Event Description
                    Text(
                      selectedEvent?.description ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Event Times
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 20, color: Colors.purple),
                        const SizedBox(width: 8),
                        Text(
                          'من ${formatEventTimeHour(selectedEvent?.startTime ?? DateTime.now())} الى ${formatEventTimeHour(selectedEvent?.endTime ?? DateTime.now())}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, color: Colors.grey),

                    // Location and Google Maps Placeholder
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 20, color: Colors.purple),
                        const SizedBox(width: 8),
                        Text(
                          selectedEvent?.locationName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: const Center(child: Text('Google Maps Placeholder')),
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1, color: Colors.grey),

                    // Ticket Classes
                    const Text(
                      'فئات التذاكر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedEvent?.availabeByTicketClass.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Center(
                              child: Text(
                                selectedEvent?.availabeByTicketClass.keys.elementAt(index) ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50), // Add space at the bottom
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      // Bottom Fixed Bar
bottomNavigationBar: Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Adjust padding
  decoration: const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, -1), // Shadow effect at the top
        blurRadius: 4.0,
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Price text
      Text(
        '${selectedEvent?.price?.toString() ?? '0'} رس',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),

      // Ticket booking button
      ElevatedButton(
              onPressed: () {
                  // Trigger the ticket purchase process
                  ref.read(ticketPurchaseProvider(TicketPurchaseParams(
                    user: user!,
                    event: selectedEvent!,
                    ticketClass: "Regular", // You can choose the ticket class
                  )));
                  

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ticket purchased successfully!')),
                  );
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF632D8C),
          minimumSize: const Size(175, 40), // Increased size for better visibility
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Set corner curve
          ),
        ),
        child: const Text(
          'احجز التذاكر',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
),

    );
  }
}
