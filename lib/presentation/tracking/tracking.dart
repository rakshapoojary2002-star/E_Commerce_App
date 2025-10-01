import 'dart:math';

import 'package:e_commerce_app/presentation/tracking/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:latlong2/latlong.dart';
import 'package:latlong2/latlong.dart' as latLng2;
import 'package:trident_tracker/trident_tracker.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final map.LatLng startPoint; // user's current location

  const DeliveryTrackingScreen({super.key, required this.startPoint});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  map.LatLng? endPoint;
  bool _isDeliveryCompleted = false;

  latLng2.LatLng convertToLatLng2(map.LatLng point) {
    return latLng2.LatLng(point.latitude, point.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Track Your Delivery",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Map Layer
          map.GoogleMap(
            initialCameraPosition: map.CameraPosition(
              target: widget.startPoint,
              zoom: 15,
            ),
            onTap: (latLng) {
              if (!_isDeliveryCompleted) {
                setState(() {
                  endPoint = latLng;
                });
              }
            },
            markers: {
              map.Marker(
                markerId: const map.MarkerId('start'),
                position: widget.startPoint,
                infoWindow: const map.InfoWindow(title: "Your Location"),
                icon: map.BitmapDescriptor.defaultMarkerWithHue(
                  map.BitmapDescriptor.hueBlue,
                ),
              ),
              if (endPoint != null)
                map.Marker(
                  markerId: const map.MarkerId('destination'),
                  position: endPoint!,
                  infoWindow: const map.InfoWindow(
                    title: "Delivery Destination",
                  ),
                  icon: map.BitmapDescriptor.defaultMarkerWithHue(
                    map.BitmapDescriptor.hueRed,
                  ),
                ),
            },
          ),

          // Route Animation Layer
          if (endPoint != null)
            TridentTracker(
              mapType: MapType.googleMaps,
              googleMapsApiKey: 'AIzaSyAdvoSXauSXeX6JtqqEzcc_MKkLM-lPSPo',
              routeAnimation: TridentRouteAnimation(
                startPoint: convertToLatLng2(widget.startPoint),
                endPoint: convertToLatLng2(endPoint!),
                duration: const Duration(seconds: 40),
                useRealRoads: true,
                routeService: RouteServiceFactory.create(),
                autoStart: true,
                polylineColor: Colors.blue,
                polylineWidth: 4.0,
                onRouteStart: () {
                  print('🛣️ Real road route started');
                },
                onProgress: (progress) {
                  print('📍 Progress: ${(progress * 100).toStringAsFixed(1)}%');
                  if (progress == 1.0 && !_isDeliveryCompleted) {
                    setState(() {
                      _isDeliveryCompleted = true;
                    });
                  }
                },
              ),
            ),

          // Instruction Card
          if (endPoint == null && !_isDeliveryCompleted)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade500],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.touch_app_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Destination",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Tap anywhere on the map",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Delivery Info Card (when destination is set)
          if (endPoint != null && !_isDeliveryCompleted)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.local_shipping_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Delivery in Progress",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Route animation active",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "40s",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(
                            Icons.location_on,
                            "Origin",
                            "${widget.startPoint.latitude.toStringAsFixed(2)}, ${widget.startPoint.longitude.toStringAsFixed(2)}",
                            Theme.of(context).colorScheme.primary,
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey.shade300,
                          ),
                          _buildInfoItem(
                            Icons.flag_rounded,
                            "Destination",
                            "${endPoint!.latitude.toStringAsFixed(2)}, ${endPoint!.longitude.toStringAsFixed(2)}",
                            Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Delivery Completed Overlay
          if (_isDeliveryCompleted) orderDelivered(),
        ],
      ),
    );
  }

  Widget orderDelivered() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Container(
          color: Colors.black.withOpacity(0.85 * value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated check icon with scale and rotation
                Transform.scale(
                  scale: value,
                  child: Transform.rotate(
                    angle: (1 - value) * 0.5,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3 * value),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Animated text with slide up effect
                Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Column(
                      children: [
                        const Text(
                          "Order Delivered!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Thank you for your order",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Animated button with slide up and scale effect
                Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: Transform.scale(
                    scale: 0.8 + (0.2 * value),
                    child: Opacity(
                      opacity: value,
                      child: AnimatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
