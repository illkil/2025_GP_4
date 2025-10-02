import 'package:flutter/material.dart';
import 'package:wujed/views/pages/item_reported_found.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

class FoundHistory extends StatefulWidget {
  const FoundHistory({super.key});

  @override
  State<FoundHistory> createState() => _FoundHistoryState();
}

class _FoundHistoryState extends State<FoundHistory> {

  String formatDate(BuildContext context, DateTime date) {
    return DateFormat.yMMMMd(Localizations.localeOf(context).toString())
        .format(date);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return ListView(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100.0,
          width: 360.0,
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
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
                          child: Image.asset(
                            'lib/assets/images/CoffeeBrew2.jpg',
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
                            style: const TextStyle(
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
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5.0),
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
                              const Icon(
                                Icons.circle,
                                size: 12,
                                color: Color.fromRGBO(255, 204, 92, 1),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                t.status_ongoing,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 204, 92, 1),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ItemReportedFound(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 15.0),

        // Item 2
        historyItem(context, "Item2", DateTime(2000, 1, 1), t.status_done,
            const Color.fromRGBO(25, 176, 0, 1)),

        const SizedBox(height: 15.0),

        // Item 3
        historyItem(context, "Item3", DateTime(2000, 1, 1), t.status_rejected,
            const Color.fromRGBO(211, 47, 47, 1)),
      ],
    );
  }

  Widget historyItem(BuildContext context, String title, DateTime date,
      String status, Color color) {
    return Container(
      height: 100.0,
      width: 360.0,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
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
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
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
                        style: const TextStyle(
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
                          const Icon(
                            Icons.calendar_month_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5.0),
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
                          const SizedBox(width: 5.0),
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
