import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/services/report_service.dart';
import 'package:wujed/views/pages/match_after_accepting_page.dart';
import 'package:wujed/views/pages/match_details_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ItemReportedLost extends StatefulWidget {
  final String reportId;
  const ItemReportedLost({super.key, required this.reportId});

  @override
  State<ItemReportedLost> createState() => _ItemReportedLostState();
}

class _ItemReportedLostState extends State<ItemReportedLost> {
  @override
  void initState() {
    super.initState();
    print('reportId: ${widget.reportId}');
  }

  void _openImageAt(int startIndex, List<String> images) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.85),
        pageBuilder: (_, __, ___) {
          final controller = PageController(initialPage: startIndex);
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  itemBuilder: (_, i) => InteractiveViewer(
                    maxScale: 5,
                    child: Image.network(
                      images[i],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
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

  bool hideMug = false;
  bool hideBrew = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ReportService().ReportStream(widget.reportId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Oops, something went wrong'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No information yet'));
        }

        final data = snapshot.data!.data() ?? {};
        final title = (data['title'] as String?)?.trim() ?? 'Untitled';
        final description = (data['description'] as String?)?.trim() ?? '—';

        String locationText = '—';
        final loc = data['location'];
        if (loc is GeoPoint) {
          locationText =
              '${loc.latitude.toStringAsFixed(5)}, ${loc.longitude.toStringAsFixed(5)}';
        } else if (loc is String && loc.trim().isNotEmpty) {
          locationText = loc.trim();
        } else if (data['address'] is String &&
            (data['address'] as String).trim().isNotEmpty) {
          locationText = (data['address'] as String).trim();
        }

        final List<String> imgs = (data['images'] as List<dynamic>? ?? const [])
            .cast<String>();
        final int headerCount = imgs.length > 2 ? 2 : imgs.length;
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
                      child: imgs.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey,
                              ),
                            )
                          : (imgs.length == 1)
                          ? GestureDetector(
                              onTap: () => _openImageAt(0, imgs),
                              child: Image.network(
                                imgs.first,
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
                            )
                          : PageView.builder(
                              controller: PageController(
                                viewportFraction: 0.88,
                              ),
                              padEnds: false,
                              itemCount: headerCount,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: index == headerCount - 1 ? 0 : 12,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () => _openImageAt(index, imgs),
                                      child: Image.network(
                                        imgs[index],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, lp) {
                                          if (lp == null) return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 48,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                              ),
                            ),
                            const PositionedDirectional(
                              top: 0,
                              bottom: 0,
                              end: 10,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: Color.fromRGBO(46, 23, 21, 1),
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

                      const SizedBox(height: 30.0),

                      Row(
                        children: [
                          Text(
                            t.lost_found_matches_title,
                            style: const TextStyle(
                              color: Color.fromRGBO(43, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(),
                      const SizedBox(height: 5.0),

                      if (!hideBrew)
                        buildMatchCard(
                          imagePath: 'lib/assets/images/CoffeeBrew2.jpg',
                          title: t.item_title_coffee_brewer,
                          description: 'Lorem ipsum dolor sit\namet, consec...',
                          confidence: t.match_confidence(90),
                          confidenceColor: const Color.fromRGBO(25, 176, 0, 1),
                          onPressed: () async {
                            final result = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => hideMug
                                    ? const MatchAfterAcceptingPage()
                                    : const MatchDetailsPage(),
                              ),
                            );
                            if (result == 'Accepted') {
                              setState(() => hideMug = true);
                            } else if (result == 'Revoked' ||
                                result == 'Rejected') {
                              setState(() {
                                hideBrew = true;
                                hideMug = false;
                              });
                            }
                          },
                        ),

                      const SizedBox(height: 20.0),

                      if (!hideMug)
                        buildMatchCard(
                          imagePath: 'lib/assets/images/CoffeeMug1.png',
                          title: t.item_title_coffee_mug,
                          description:
                              'Consectetur adipiscing\nelit, sed do ei...',
                          confidence: t.match_confidence(79),
                          confidenceColor: const Color.fromRGBO(
                            255,
                            204,
                            92,
                            1,
                          ),
                          onPressed: () {},
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

  Widget buildMatchCard({
    required String imagePath,
    required String title,
    required String description,
    required String confidence,
    required Color confidenceColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 120.0,
      width: 360.0,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100.0,
            child: Stack(
              children: [
                SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(imagePath),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 110,
                  top: 10,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                PositionedDirectional(
                  start: 110,
                  top: 30,
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ),
                PositionedDirectional(
                  start: 110,
                  top: 70,
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: confidenceColor),
                      const SizedBox(width: 5.0),
                      Text(
                        confidence,
                        style: TextStyle(
                          color: confidenceColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  bottom: 0,
                  end: 5,
                  child: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
