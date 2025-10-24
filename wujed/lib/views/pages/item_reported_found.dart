import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/services/report_service.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ItemReportedFound extends StatefulWidget {
  final String reportId;
  const ItemReportedFound({super.key, required this.reportId});

  @override
  State<ItemReportedFound> createState() => _ItemReportedFoundState();
}

class _ItemReportedFoundState extends State<ItemReportedFound> {
  @override
  void initState() {
    super.initState();
  }

  void _openImage(String url) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 180),
        pageBuilder: (_, __, ___) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    maxScale: 5,
                    child: Image.network(url, fit: BoxFit.contain),
                  ),
                ),
                PositionedDirectional(
                  top: MediaQuery.of(context).padding.top + 8,
                  end: 8,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ReportService().ReportStream(widget.reportId),
      builder: (context, snapshot) {
        //1. loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        //2. error
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text(t.common_error_generic)));
        }
        //3. no data
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(body: Center(child: Text(t.common_empty)));
        }

        final data = snapshot.data!.data() ?? {};
        final title = (data['title'] as String?)?.trim() ?? t.common_untitled;
        final description =
            (data['description'] as String?)?.trim() ?? t.label_value_missing;

        String locationText = t.label_value_missing;
        GeoPoint? geo;
        final loc = data['location'];
        if (loc is GeoPoint) {
          geo = loc;
          locationText = (data['address'] as String?)?.trim().isNotEmpty == true
              ? (data['address'] as String).trim()
              : '${loc.latitude.toStringAsFixed(5)}, ${loc.longitude.toStringAsFixed(5)}';
        } else if (data['address'] is String &&
            (data['address'] as String).trim().isNotEmpty) {
          locationText = (data['address'] as String).trim();
        }

        final List<String> imgs = (data['images'] as List<dynamic>? ?? const [])
            .cast<String>();
        final headerUrl = imgs.isNotEmpty ? imgs.first : null;
        const double heroH = 400.0;

        return Scaffold(
          backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: heroH,
                      child: headerUrl == null
                          ? const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey,
                              ),
                            )
                          : GestureDetector(
                              onTap: () => _openImage(headerUrl),
                              child: Image.network(
                                headerUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, lp) {
                                  if (lp == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.broken_image,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                    ),
                    PositionedDirectional(
                      top: 70,
                      start: 20,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const BackButton(),
                      ),
                    ),
                    PositionedDirectional(
                      start: 0,
                      end: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 235, 190, 1),
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(20),
                              topEnd: Radius.circular(20),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Color.fromRGBO(46, 23, 21, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            t.details_location_label,
                            style: const TextStyle(
                              color: Color.fromRGBO(43, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),

                      Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            const PositionedDirectional(
                              top: 0,
                              bottom: 0,
                              start: 20,
                              child: Icon(
                                IconlyBold.location,
                                color: Color.fromRGBO(46, 23, 21, 1),
                                size: 37,
                              ),
                            ),
                            PositionedDirectional(
                              top: 18,
                              start: 100,
                              child: Text(
                                locationText,
                                style: const TextStyle(
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              bottom: 0,
                              end: 10,
                              child: IconButton(
                                onPressed: geo == null
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MapPreviewPage(
                                              lat: geo!.latitude,
                                              lng: geo!.longitude,
                                              title: locationText,
                                            ),
                                          ),
                                        );
                                      },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      Row(
                        children: [
                          Text(
                            t.details_description_label,
                            style: const TextStyle(
                              color: Color.fromRGBO(43, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),

                      Container(
                        height: 169,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            description,
                            style: const TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      FilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierColor: Colors.black54,
                            builder: (_) => AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              alignment: Alignment.center,
                              titlePadding: const EdgeInsets.fromLTRB(
                                20,
                                20,
                                20,
                                0,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                20,
                                10,
                                20,
                                20,
                              ),
                              actionsPadding: const EdgeInsets.fromLTRB(
                                20,
                                0,
                                20,
                                20,
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    t.dialog_are_you_sure,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(46, 23, 21, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                t.report_cancel_dialog_info,
                                textAlign: TextAlign.center,
                              ),
                              actionsAlignment: MainAxisAlignment.end,
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    //hard delete from database then navigate to history
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  style: FilledButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      45,
                                    ),
                                    backgroundColor: const Color.fromRGBO(
                                      46,
                                      23,
                                      21,
                                      1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    t.btn_confirm,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      45,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    t.btn_cancel,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(46, 23, 21, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(170, 45),
                          backgroundColor: const Color.fromRGBO(166, 91, 91, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          t.btn_cancel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MapPreviewPage extends StatelessWidget {
  final double lat;
  final double lng;
  final String title;
  const MapPreviewPage({
    super.key,
    required this.lat,
    required this.lng,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final point = LatLng(lat, lng);
    return Scaffold(
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: FlutterMap(
        options: MapOptions(initialCenter: point, initialZoom: 16),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.gp.wujed',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: point,
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
