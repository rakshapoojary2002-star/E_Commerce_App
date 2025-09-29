// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:trident_tracker/trident_tracker.dart';
// import 'package:trident_tracker/trident_tracker_options.dart';
// import 'package:trident_tracker/trident_route_animation.dart';
// import 'package:trident_tracker/trident_route_service_factory.dart';
// import 'package:trident_tracker/trident_route_service.dart';

// class DeliveryTrackingScreen extends StatefulWidget {
//   final LatLng startPoint; // user's current location
//   const DeliveryTrackingScreen({super.key, required this.startPoint});

//   @override
//   State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
// }

// class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
//   LatLng? endPoint;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Track Your Delivery")),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: widget.startPoint,
//                     zoom: 15,
//                   ),
//                   onTap: (latLng) {
//                     setState(() {
//                       endPoint = latLng;
//                     });
//                   },
//                   markers: endPoint != null
//                       ? {
//                           Marker(
//                             markerId: const MarkerId('destination'),
//                             position: endPoint!,
//                           ),
//                         }
//                       : {},
//                 ),
//                 if (endPoint != null)
//                   TridentTracker(
//                     mapType: MapType.googleMaps,
//                     googleMapsApiKey: "YOUR_GOOGLE_MAPS_API_KEY",
//                     routeAnimation: TridentRouteAnimation.vehicle(
//                       startPoint: widget.startPoint,
//                       endPoint: endPoint!,
//                       duration: const Duration(seconds: 30),
//                       useRealRoads: true,
//                       autoStart: true,
//                       polylineColor: Colors.blue,
//                       polylineWidth: 5,
//                       onProgress: (progress) {
//                         print(
//                             "Progress: ${(progress * 100).toStringAsFixed(1)}%");
//                       },
//                       onRouteEnd: () => print("Delivery reached!"),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           if (endPoint == null)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Tap on the map to select your delivery destination",
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
