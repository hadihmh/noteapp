import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_location_app/domain/api/call_api.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  var location = Location();
  Dio dio = Dio();
  late Timer locationTimer;
  void currentLocation(GoogleMapController controller) async {
    LocationData? currentLocation;
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation?.latitude ?? 10.10,
            currentLocation?.longitude ?? 10.10),
        zoom: 17.0,
      ),
    ));
  }

  void sendLocationToServer() async {
    try {
      LocationData userLocation = await location.getLocation();
      if (userLocation.latitude != null && userLocation.latitude != null) {
        var response = await CallApis().sendLocation(LatLng(
            userLocation.latitude ?? 0.0, userLocation.longitude ?? 0.0));
        debugPrint(response.ok.toString());
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  startTimer() {
    locationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      debugPrint("Location sent to server");
    });
  }
}
