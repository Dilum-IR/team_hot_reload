import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  // setup camera position for new change current position
  Future<void> cameraToPosition(LatLng pos, dynamic _controller) async {
    final GoogleMapController controller = await _controller.future;

    CameraPosition cameraPosition = CameraPosition(
      target: pos,
      zoom: 15,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}
