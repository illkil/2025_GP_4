import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong2/latlong.dart';
import 'package:wujed/utils/dialogs.dart';
import 'package:wujed/widgets/bottom_sheet_widget.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  GoogleMapController? _map;
  LatLng? _picked;

  final LatLng _center = LatLng(24.7136, 46.6753);
  final riyadhLatMin = 24.3;
  final riyadhLatMax = 25.1;
  final riyadhLonMin = 46.3;
  final riyadhLonMax = 47.1;

  void _onMapCreated(GoogleMapController controller) {
  _map = controller;
  }

  void _onTap(LatLng position) {
    final isInside = position.latitude >= riyadhLatMin &&
                   position.latitude <= riyadhLatMax &&
                   position.longitude >= riyadhLonMin &&
                   position.longitude <= riyadhLonMax;

    if (!isInside) {
      final t = AppLocalizations.of(context);
      showAppDialog(context, t.outside_riyadh, t.outside_dialog);
      return;
  }

  setState(() => _picked = position);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _choice();
    });
  }

  @override
  void dispose() {
    _map?.dispose();
    super.dispose();
  }

  Future<void> _choice() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) => const BottomSheetWidget(page: 'PickLocationPage'),
    );
    if (choice == 'current') {
      await currentLocation();
    } else if (choice == 'manual') {}
  }

  //method to get the current location of the user
  Future<void> currentLocation() async {
    final t = AppLocalizations.of(context);
    try {
      //1. Check if the user enabled location services
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await showAppDialog(
          context,
          t.sheet_choose_location_title,
          t.sheet_current_location_sub,
        );
        return;
      }

      //2. Check permission
      var permission = await Geolocator.checkPermission();
      //If permission is denied request for permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await showAppDialog(
            context,
            t.sheet_choose_location_title,
            t.sheet_choose_manually,
          );
          return;
        }
      }
      //If denied forever open app settings to turn it on
      if (permission == LocationPermission.deniedForever) {
        await showAppDialog(
          context,
          t.sheet_choose_location_title,
          t.sheet_choose_manually,
        );
        await Geolocator.openAppSettings();
        return;
      }

      final currentLocation = await Geolocator.getCurrentPosition();

      final lat = currentLocation.latitude;
      final lon = currentLocation.longitude;
      final isInsideRiyadh =
        lat >= riyadhLatMin && lat <= riyadhLatMax &&
        lon >= riyadhLonMin && lon <= riyadhLonMax;

      if (!isInsideRiyadh) {
        await showAppDialog(context, t.outside_riyadh, t.outside_dialog);
        return;
      } else {
         setState(() {
          _picked = LatLng(lat, lon);
        });
      }
      if (_map != null) {
        await _map!.animateCamera(
          CameraUpdate.newLatLngZoom(_picked!, 16),
        );
      }

    } catch (e) {
      await showAppDialog(
        context,
        t.sheet_choose_location_title,
        t.common_error_generic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final Set<Marker> markerSet = _picked == null
    ? {
        Marker(
          markerId: const MarkerId('center'),
          position: _center,      
        ),
      }
    : {
        Marker(
          markerId: const MarkerId('picked'),
          position: _picked!,
        ),
      };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            minMaxZoomPreference: const MinMaxZoomPreference(11.5, 17),
            initialCameraPosition: 
              CameraPosition(
                target: 
                  LatLng(24.7136, 46.6753), 
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
            onTap: _onTap,
            markers: markerSet,
          ),
          /*FlutterMap(
            mapController: _map,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              onTap: (tapPosition, point) {
                setState(() {
                  _picked = point;
                  print('Picked: $_picked');
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.gp.wujed',
              ),
              if (_picked != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _picked!,
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
          ),*/
          PositionedDirectional(
            start: 16,
            end: 16,
            bottom: 24,
            child: SafeArea(
              child: FilledButton(
                onPressed: _picked == null
                  ? null
                  : () async {
                      // 1. get the coordinates
                      final lat = _picked!.latitude;
                      final lng = _picked!.longitude;

                      // 2️. reverse it to the address
                      String? address;
                      try {
                        final placemarks = await placemarkFromCoordinates(
                          lat,
                          lng,
                        );
                        if (placemarks.isNotEmpty) {
                          final p = placemarks.first;
                          address =
                            [
                              p.name,
                              p.locality,
                              p.administrativeArea,
                              p.country,
                            ]
                            .where((e) => e != null && e!.isNotEmpty)
                            .join(', ');
                        }
                      } catch (e) {
                        address = null; // if fails
                      }

                      // 3️. pop back to the previous screen with data
                      if (context.mounted) {
                        Navigator.pop(context, {
                          'lat': lat,
                          'lng': lng,
                          'address': address,
                        });
                      }
                    },

                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _picked == null ? t.sheet_choose_manually : t.btn_confirm,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
