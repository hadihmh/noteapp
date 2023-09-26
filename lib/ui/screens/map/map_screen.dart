import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_location_app/controllers/map_controller.dart';
import 'package:live_location_app/domain/config/config.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = Get.put(MapController());
  @override
  void initState() {
    super.initState();
    mapController.startTimer();
  }

  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Google Maps')),
          backgroundColor: Colors.amber,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => mapController.currentLocation(_controller),
          label: const Text('My Location'),
          icon: const Icon(Icons.location_on),
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: Config.defaultZoom,
            zoom: 14.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          onTap: (LatLng latLng) {
            // Add a new marker to the map
          },
        ));
  }
}
