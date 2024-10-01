// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:url_launcher/url_launcher.dart';

// class EventMapWidget extends StatelessWidget {
//   final double latitude;
//   final double longitude;
//   final String locationName; // Optional location name for the map URL

//   const EventMapWidget({
//     Key? key,
//     required this.latitude,
//     required this.longitude,
//     required this.locationName,
//   }) : super(key: key);

//   // Function to open the location in an external map application
//   Future<void> _openInExternalMap() async {
//     final mapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//     if (await canLaunch(mapUrl)) {
//       await launch(mapUrl);
//     } else {
//       throw 'Could not open the map';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _openInExternalMap, // Make the map clickable
//       child: Container(
//         height: 200, // Adjust the height of the map as needed
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               spreadRadius: 2,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12.0), // Rounded corners for the map
//           child: GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(latitude, longitude),
//               zoom: 14, // Adjust the zoom level as needed
//             ),
//             markers: {
//               Marker(
//                 markerId: MarkerId('eventLocation'),
//                 position: LatLng(latitude, longitude),
//                 infoWindow: InfoWindow(title: locationName), // Show the location name
//               ),
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
