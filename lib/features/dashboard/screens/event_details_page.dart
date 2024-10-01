import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data to be replaced with real data
    final eventTitle = 'استمتع بليلة طربية ساحرة';
    final eventDate = '6 سبتمبر 2024';
    final eventDescription =
        'انضموا لنا في ليلة مليئة بالإحساس والمشاعر والكشوف في المسرح بمدينة الرياض';
    final eventTime = 'من 9:00 مساءً حتى 1:00 صباحاً';
    final locationName = 'حديقة الملك فهد - جدة';
    final ticketClasses = ['عادية', 'بريميوم'];
    final price = 280.0;
    final imageUrls = [
      'https://picsum.photos/200',
      'https://picsum.photos/200'
    ]; // Sample image URLs

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                Container(
                  height: 250,
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Event Title and Date
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            eventDate,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.calendar_today,
                                size: 16, color: Colors.purple),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  color: const Color.fromARGB(100, 0, 0, 0),
                  endIndent: 10,
                  indent: 10,
                ),

                // Event Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    eventDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: const Color.fromARGB(100, 0, 0, 0),
                  endIndent: 10,
                  indent: 10,
                ),

                // Event Times
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 20, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(
                        eventTime,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: const Color.fromARGB(100, 0, 0, 0),
                  endIndent: 10,
                  indent: 10,
                ),

                // Location and Google Maps Placeholder
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 20, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(
                            locationName,
                            style: TextStyle(
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
                          color:
                              Colors.grey[300], // Placeholder for Google Maps
                        ),
                        child: Center(child: Text('Google Maps Placeholder')),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: Colors.grey[300]),

                // Ticket Classes (Horizontal Scroll)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
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
                          itemCount: ticketClasses.length,
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
                                  ticketClasses[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Add space at the bottom
              ],
            ),
          ),
          // Bottom Fixed Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' $price رس',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'احجز التذاكر',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF632D8C),
                      minimumSize: Size(175, 40), // Set the size of the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Set the corner curve
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
