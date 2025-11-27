import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:wujed/views/pages/item_reported_lost.dart';
import 'package:wujed/views/pages/notifications_page.dart';
import 'package:wujed/views/pages/report_found_page.dart';
import 'package:wujed/views/pages/report_lost_page.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  //FOR NOTIFICATION SIMULATION
  bool _showRejectedBanner = false;
  bool _hasRejectedNotification = false;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _rejectedSub;

  //FOR NOTIFICATION SIMULATION
  Stream<QuerySnapshot<Map<String, dynamic>>> _checkLastRejectedReportOnce() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _db
        .collection('reports')
        .where('ownerUid', isEqualTo: uid)
        .where('status', isEqualTo: 'rejected')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  //FOR NOTIFICATION SIMULATION
  @override
  void initState() {
    super.initState();

    _rejectedSub = _checkLastRejectedReportOnce().listen((snapshot) async {
      if (!mounted) return;
      if (snapshot.docs.isEmpty) return;

      final data = snapshot.docs.first.data();
      final status = data['status'];

      if (status == 'rejected' && !_showRejectedBanner) {
        setState(() {
          _showRejectedBanner = true;
          _hasRejectedNotification = true;
        });

        await Future.delayed(const Duration(seconds: 3));

        if (mounted) {
          setState(() => _showRejectedBanner = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _rejectedSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 320.0,
                  color: const Color.fromRGBO(255, 204, 92, 0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'lib/assets/images/Logo.png',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationsPage(
                                      showRejectedNotification:
                                          _hasRejectedNotification,
                                    ),
                                  ),
                                );
                              },
                              icon: Stack(
                                children: [
                                  const Icon(
                                    IconlyBold.notification,
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    size: 40,
                                  ),
                                  const PositionedDirectional(
                                    end: 3,
                                    top: 0,
                                    child: Icon(
                                      Icons.circle,
                                      color: Color.fromRGBO(255, 0, 0, 1),
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        t.home_what_item_question,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReportLostPage(),
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(150.0, 40.0),
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
                              t.home_lost_button,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReportFoundPage(),
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(150.0, 40.0),
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
                              t.home_found_button,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            t.home_stats_brand,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 175, 0, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            t.home_stats_suffix,
                            style: const TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: [
                            _buildStatCard(
                              icon: MaterialSymbols.fact_check_rounded,
                              title: t.home_stat_reports_title,
                              value: t.home_stat_reports_value,
                            ),
                            const SizedBox(width: 20.0),
                            _buildStatCard(
                              icon: Ri.hand_coin_fill,
                              title: t.home_stat_items_title,
                              value: t.home_stat_items_value,
                            ),
                            const SizedBox(width: 20.0),
                            _buildStatCard(
                              icon: Bi.stars,
                              title: t.home_stat_matches_title,
                              value: t.home_stat_matches_value,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      StreamBuilder(
                        stream: _db
                            .collection('reports')
                            .where(
                              'ownerUid',
                              isEqualTo: _auth.currentUser?.uid,
                            )
                            .where('type', isEqualTo: 'lost')
                            .where('status', isEqualTo: 'ongoing')
                            .orderBy('createdAt', descending: true)
                            .limit(1)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text(
                              t.home_note,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            );
                          }
                          final report = snapshot.data!.docs.first;
                          final data = report.data();
                          final imgs = (data['images'] as List<dynamic>? ?? [])
                              .cast<String>();
                          final imageUrl = imgs.isNotEmpty ? imgs.first : null;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemReportedLost(reportId: report.id),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 100.0,
                              width: 360.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromRGBO(
                                        0,
                                        0,
                                        0,
                                        0.05,
                                      ),
                                      offset: const Offset(0, 4),
                                      blurRadius: 16,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 100.0,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 80.0,
                                          width: 80.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child:
                                                imageUrl != null &&
                                                    imageUrl.isNotEmpty
                                                ? Image.network(
                                                    imageUrl,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (_, __, ___) => Icon(
                                                          Icons.image,
                                                          size: 50.0,
                                                          color: Colors
                                                              .grey
                                                              .shade400,
                                                        ),
                                                  )
                                                : Icon(
                                                    Icons.image,
                                                    size: 50.0,
                                                    color: Colors.grey.shade400,
                                                  ),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            PositionedDirectional(
                                              top: 10,
                                              start: 95,
                                              child: Text(
                                                data['title'],
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                    46,
                                                    23,
                                                    21,
                                                    1,
                                                  ),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              top: 35,
                                              start: 95,
                                              child: Text(
                                                t.home_card_subtitle,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        PositionedDirectional(
                                          top: 0,
                                          bottom: 0,
                                          end: 10,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                255,
                                                204,
                                                92,
                                                0.4,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ItemReportedLost(
                                                          reportId: report.id,
                                                        ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_showRejectedBanner)
            const Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: _RejectedNotificationCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String title,
    required String value,
  }) {
    return SizedBox(
      height: 200.0,
      width: 190,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 20,
              start: 15,
              child: Container(
                height: 60.0,
                width: 60.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 204, 92, 0.4),
                  shape: BoxShape.circle,
                ),
                child: Iconify(
                  icon,
                  size: 37,
                  color: const Color.fromRGBO(46, 23, 21, 1),
                ),
              ),
            ),
            PositionedDirectional(
              top: 30,
              start: 85,
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 0,
              child: Container(
                height: 80,
                width: 145,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 204, 92, 0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//FOR NOTIFICATION SIMULATION
class _RejectedNotificationCard extends StatelessWidget {
  const _RejectedNotificationCard();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 204, 92, 1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.notifications_active_outlined,
                size: 26,
                color: Color.fromRGBO(46, 23, 21, 1),
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wujed",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(46, 23, 21, 1),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.reject_notif,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),
            const Icon(Icons.more_horiz, size: 22, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
