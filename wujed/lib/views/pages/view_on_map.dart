import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewOnMapPage extends StatelessWidget {
  const ViewOnMapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    this.title,
  });

  final double latitude;
  final double longitude;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final center = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(title ?? 'Location'),
      ),
      backgroundColor: Colors.white,
      body: GoogleMap(
        mapType: MapType.normal,
        minMaxZoomPreference: const MinMaxZoomPreference(8, 17),
        initialCameraPosition: 
          CameraPosition(
            target: center,
            zoom: 12, 
            tilt: 0, 
            bearing: 0,
          ),
        cameraTargetBounds: 
          CameraTargetBounds(
            LatLngBounds(
              southwest: LatLng(24.4, 46.4), 
              northeast: LatLng(25.1, 47.1), 
            ),
          ),
        markers: {
          Marker(
            markerId: const MarkerId('center'),
            position: center,
          ),
        },
      ),
    );
  }
}
