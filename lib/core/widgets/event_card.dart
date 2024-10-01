import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_tickets/classes/event.dart';
import 'package:just_tickets/features/dashboard/provider/events_provider.dart';
import 'package:just_tickets/features/dashboard/screens/event_details_page.dart';

import '../../services/date_format.dart';

class EventCard extends ConsumerWidget {
 
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
       onTap: () {
              ref.read(selectedEventProvider.notifier).state = event;
     Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(),
          ),
        );
      
       },
   
      child: Container(
        // padding: const EdgeInsets.all(12.0),
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
       
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   ListTile(
                    contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      
                      title: Text(event.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(event.description),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatEventDate(event.startTime)),
                          Text(event.locationName),
                        ],
                      ),
                    ),
      
                 
                  ],
                ),
              ),
            ),
                 Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: 150,
                  height: 150,
                  
                   child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                     child: Image.network(
                                 event.imageUrl,
                          
                                 fit: BoxFit.cover,
                               ),
                   ),
                 ),
          ],
        ),
      ),
    );
  }
}
