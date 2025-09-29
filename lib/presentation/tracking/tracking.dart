import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:latlong2/latlong.dart';
import 'package:trident_tracker/trident_tracker.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final map.LatLng startPoint; // user's current location

  const DeliveryTrackingScreen({super.key, required this.startPoint});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  map.LatLng? endPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Your Delivery")),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                map.GoogleMap(
                  initialCameraPosition: map.CameraPosition(
                    target: widget.startPoint,
                    zoom: 15,
                  ),
                  onTap: (latLng) {
                    setState(() {
                      endPoint = latLng;
                    });
                  },
                  markers: {
                    map.Marker(
                      markerId: const map.MarkerId('start'),
                      position: widget.startPoint,
                      infoWindow: const map.InfoWindow(title: "Start Point"),
                    ),
                    if (endPoint != null)
                      map.Marker(
                        markerId: const map.MarkerId('destination'),
                        position: endPoint!,
                        infoWindow: const map.InfoWindow(title: "End Point"),
                      ),
                  },
                ),

                if (endPoint != null)
                  TridentTracker(
                    mapType: MapType.googleMaps,
                    googleMapsApiKey: 'AIzaSyAdvoSXauSXeX6JtqqEzcc_MKkLM-lPSPo',
                    routeAnimation: TridentRouteAnimation(
                      startPoint: LatLng(12.8968, 74.8346),
                      endPoint: LatLng(12.9224, 74.8310),
                      duration: Duration(seconds: 20),
                      useRealRoads: true,
                      routeService: RouteServiceFactory.create(),
                      autoStart: true,
                      polylineColor: Colors.blue,
                      polylineWidth: 4.0,
                      onRouteStart: () {
                        print('🛣️ Real road route started');
                      },
                      onProgress: (progress) {
                        print(
                          '📍 Progress: ${(progress * 100).toStringAsFixed(1)}%',
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          if (endPoint == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Tap on the map to select your delivery destination",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
