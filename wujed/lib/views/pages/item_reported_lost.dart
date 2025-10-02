import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/views/pages/match_after_accepting_page.dart';
import 'package:wujed/views/pages/match_details_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ItemReportedLost extends StatefulWidget {
  const ItemReportedLost({super.key});

  @override
  State<ItemReportedLost> createState() => _ItemReportedLostState();
}

class _ItemReportedLostState extends State<ItemReportedLost> {
  final _imgPath = 'lib/assets/images/CoffeeBrew.WEBP';
  final _heroTag = 'item-image-hero';

  bool hideMug = false;
  bool hideBrew = false;

  void _openImage() {
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
                  child: Hero(
                    tag: _heroTag,
                    child: InteractiveViewer(
                      maxScale: 5,
                      child: Image.asset(_imgPath, fit: BoxFit.contain),
                    ),
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

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: GestureDetector(
                    onTap: _openImage,
                    child: Image.asset(
                      'lib/assets/images/CoffeeBrew.WEBP',
                      fit: BoxFit.cover,
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
                        alignment: const Alignment(0, 0),
                        child: Text(
                          t.item_title_coffee_brewer,
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
                        const PositionedDirectional(
                          top: 18,
                          start: 100,
                          child: Text(
                            'XYZLOCATIONXYZXYZXYZ',
                            style: TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 0,
                          bottom: 0,
                          end: 10,
                          child: IconButton(
                            onPressed: () {},
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
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut '
                        'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in '
                        'voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                        style: TextStyle(
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
                            builder: (_) =>
                                hideMug ? const MatchAfterAcceptingPage() : const MatchDetailsPage(),
                          ),
                        );
                        if (result == 'Accepted') {
                          setState(() => hideMug = true);
                        } else if (result == 'Revoked' || result == 'Rejected') {
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
                      description: 'Consectetur adipiscing\nelit, sed do ei...',
                      confidence: t.match_confidence(79),
                      confidenceColor: const Color.fromRGBO(255, 204, 92, 1),
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
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
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
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
