import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wujed/services/report_service.dart';
import 'package:wujed/views/pages/item_reported_lost.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

Color statusToColor(String status) {
  switch (status.toLowerCase()) {
    case 'ongoing':
      return const Color.fromRGBO(255, 204, 92, 1);
    case 'done':
      return const Color.fromRGBO(25, 176, 0, 1);
    case 'rejected':
      return const Color.fromRGBO(211, 47, 47, 1);
    case 'match_found':
      return const Color.fromRGBO(0, 111, 255, 1);
    case 'expired':
      return const Color.fromRGBO(125, 132, 141, 1);
    default:
      return Colors.grey;
  }
}

class LostHistory extends StatefulWidget {
  const LostHistory({super.key});

  @override
  State<LostHistory> createState() => _LostHistoryState();
}

class _LostHistoryState extends State<LostHistory> {
  bool notFound = true;

  String formatDate(BuildContext context, DateTime date) {
    return DateFormat.yMMMMd(
      Localizations.localeOf(context).toString(),
    ).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    //this StreamBuilder listens live to the stream lostReportsStream and rebuilds the UI to show it accordingly
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: ReportService().lostReportsStream(),
      builder: (context, snapshot) {
        //1. if loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        //2. if error
        if (snapshot.hasError) {
          return const Center(child: Text('Oops, something went wrong'));
        }

        //3. if no data is returned (empty)
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text('No lost reports yet'));
        }

        //4. otherwise list data
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data();

            final imgs = (data['images'] as List<dynamic>? ?? [])
                .cast<String>();
            final imageUrl = imgs.isNotEmpty ? imgs.first : null;

            final title = (data['title'] as String?)?.trim().isNotEmpty == true
                ? data['title']
                : 'Untitled';

            final ts = data['createdAt'] as Timestamp?;
            final date = ts?.toDate() ?? DateTime.now();

            final status = (data['status'] as String?) ?? 'submitted';
            final color = statusToColor(status);

            //the item listed, if clicked it takes to the details page
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == docs.length - 1 ? 0 : 15.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemReportedLost(reportId: doc.id),
                    ),
                  );
                },
                child: historyItem(
                  context,
                  title,
                  date,
                  status,
                  color,
                  imageUrl,
                ),
              ),
            );
          },
        );
      },
    );

    /*return ListView(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100.0,
          width: 360.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(4, 4),
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
                      height: 80.0,
                      width: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'lib/assets/images/CoffeeBrew.WEBP',
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        PositionedDirectional(
                          top: 5,
                          start: 95,
                          child: Text(
                            t.item_title_coffee_brewer,
                            style: TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 30,
                          start: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                formatDate(context, DateTime(2025, 1, 1)),
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          top: 57,
                          start: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: notFound
                                    ? Color.fromRGBO(255, 204, 92, 1)
                                    : Color.fromRGBO(25, 176, 0, 1),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                notFound ? t.status_ongoing : t.status_done,
                                style: TextStyle(
                                  color: notFound
                                      ? Color.fromRGBO(255, 204, 92, 1)
                                      : Color.fromRGBO(25, 176, 0, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      end: 0,
                      child: IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ItemReportedLost();
                              },
                            ),
                          );
                          if (result == 'Done') {
                            setState(() {
                              notFound = false;
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15.0),

        // Item 2
        historyItem(
          context,
          "Item2",
          DateTime(2000, 1, 1),
          t.status_done,
          Color.fromRGBO(25, 176, 0, 1),
        ),

        SizedBox(height: 15.0),

        // Item 3
        historyItem(
          context,
          "Item3",
          DateTime(2000, 1, 1),
          t.status_rejected,
          Color.fromRGBO(211, 47, 47, 1),
        ),

        SizedBox(height: 15.0),

        // Item 4
        historyItem(
          context,
          "Item4",
          DateTime(2000, 1, 1),
          t.status_match_found,
          Color.fromRGBO(0, 111, 255, 1),
        ),

        SizedBox(height: 15.0),

        // Item 5
        historyItem(
          context,
          "Item5",
          DateTime(2000, 1, 1),
          t.status_expired,
          Color.fromRGBO(125, 132, 141, 1),
        ),
      ],
    );*/
  }

  Widget historyItem(
    BuildContext context,
    String title,
    DateTime date,
    String status,
    Color color, [
    String? imageUrl,
  ]) {
    return Container(
      height: 100.0,
      width: 360.0,
      decoration: BoxDecoration(
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
                  height: 80.0,
                  width: 80.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.image,
                                size: 50.0,
                                color: Colors.grey.shade400,
                              ),
                            )
                          : Icon(
                              Icons.image,
                              size: 50.0,
                              color: Colors.grey.shade400,
                            ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    PositionedDirectional(
                      top: 5,
                      start: 95,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: 30,
                      start: 95,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            formatDate(context, date),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PositionedDirectional(
                      top: 57,
                      start: 95,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 12, color: color),
                          SizedBox(width: 5.0),
                          Text(
                            status,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: 0,
                  bottom: 0,
                  end: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
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
