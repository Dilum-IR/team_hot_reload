import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../components/widget/comman_widget/alert_popup.dart';

class LocationService {
  final key = dotenv.env['GOOGLE_MAPS_API_KEY'];
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  Future<String> getAddressFromLatLng(LatLng tappedPoint) async {
    final lat = tappedPoint.latitude;
    final lng = tappedPoint.longitude;
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse['status'] == 'OK') {
        final choose_address = decodedResponse['results'][0]
                ['address_components'][1]['long_name'] +
            "," +
            decodedResponse['results'][0]['address_components'][2]
                ['long_name'] +
            "," +
            decodedResponse['results'][0]['address_components'][4]
                ['long_name'] +
            ".";

        // return decodedResponse['results'][0]['formatted_address'];
        return choose_address;
      } else {
        AlertPopup.warning(
            title: "Location Failed",
            message: "Failed to retrieve address. Try again later.",
            type: 2);
        throw Exception('Failed to retrieve address');
      }
    } else {
      AlertPopup.warning(
          title: "Location Failed",
          message: "Location not found. Try again later.",
          type: 1);
      throw Exception('Failed to fetch data');
    }
  }

  void addOneMarker(LatLng tappedPoint, String locationName) {
    try {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.longitude.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: locationName,
            snippet:
                '${tappedPoint.latitude.toStringAsFixed(6)} , ${tappedPoint.longitude.toStringAsFixed(6)}',
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // get user taped locations
  Set<Marker> getOneMarker() {
    return _markers;
  }

  // Clear stored tapped points
  void clearTappedPoints() {
    _markers.clear();
  }
}
