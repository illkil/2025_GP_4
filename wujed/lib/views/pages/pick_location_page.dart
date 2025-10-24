import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:wujed/utils/dialogs.dart';
import 'package:wujed/widgets/bottom_sheet_widget.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  final MapController _map = MapController();
  LatLng? _picked;
  final LatLng _center = const LatLng(24.7136, 46.6753);
  final double _zoom = 12;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openLegacyChoiceSheet();
    });
  }

  Future<void> _openLegacyChoiceSheet() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (ctx) => const BottomSheetWidget(page: 'PickLocationPage'),
    );
    if (choice == 'current') {
      await currentLocaiton();
    } else if (choice == 'manual') {}
  }

  //method to get the current location of the user
  Future<void> currentLocaiton() async {
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

      //3. Get current location and set it
      final currentLocation = await Geolocator.getCurrentPosition();

      setState(() {
        _picked = LatLng(currentLocation.latitude, currentLocation.longitude);
      });

      _map.move(_picked!, 16);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FlutterMap(
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
          ),
          //confirm button with info
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: SafeArea(
              child: FilledButton(
                onPressed: _picked == null
                    ? null
                    : () async {
                        // 1. get the coordinates
                        final lat = _picked!.latitude;
                        final lng = _picked!.longitude;

                        // 2️. try reverse it to the address
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
