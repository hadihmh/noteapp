import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_location_app/domain/api/base_api.dart';
import 'package:live_location_app/domain/config/routes.dart';
import 'package:live_location_app/domain/models/location_model.dart';
import 'package:live_location_app/domain/models/response_location_model.dart';

class CallApis extends BaseAPI {
  Future<ResponseLocationModel> sendLocation(LatLng latLng) async {
    var result = await post(
        route: Routes.location,
        body: LocationModel(
                lat: latLng.latitude.toString(),
                lang: latLng.longitude.toString())
            .toJson());
    return ResponseLocationModel.fromJson(result);
  }
}
