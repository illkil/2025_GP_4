import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
      body: FlutterMap(
        options: MapOptions(initialCenter: center, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.gp.wujed',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: center,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
