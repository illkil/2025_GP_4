import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class NotificationsPage extends StatelessWidget {
  final bool showRejectedNotification;

  const NotificationsPage({super.key, required this.showRejectedNotification});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.notifications_title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(),

          if (showRejectedNotification) ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 80,
                width: double.infinity,
                child: Stack(
                  children: [
                    PositionedDirectional(
                      start: 20,
                      child: Row(
                        children: [
                          Text(
                            t.report_rejected,
                            style: const TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ],
                      ),
                    ),

                    PositionedDirectional(
                      start: 20,
                      top: 20,
                      child: SizedBox(
                        width: width - 100,
                        child: Text(
                          t.reject_notif,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    PositionedDirectional(end: 20, child: Text(t.now)),
                  ],
                ),
              ),
            ),
            const Divider(),
          ],

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  PositionedDirectional(
                    start: 20,
                    child: Row(
                      children: [
                        Text(
                          t.notifications_expired_title,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    start: 20,
                    top: 20,
                    child: SizedBox(
                      width: width - 100,
                      child: Text(
                        t.notifications_expired_body,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 20,
                    child: Text(t.notifications_time_2d),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  PositionedDirectional(
                    start: 20,
                    child: Row(
                      children: [
                        Text(
                          t.notifications_new_match_title,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    start: 20,
                    top: 20,
                    child: SizedBox(
                      width: width - 100,
                      child: Text(
                        t.notifications_new_match_body,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 20,
                    child: Text(t.notifications_time_6d),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  PositionedDirectional(
                    start: 20,
                    child: Row(
                      children: [
                        Text(
                          t.notifications_expiring_soon_title,
                          style: const TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    start: 20,
                    top: 20,
                    child: SizedBox(
                      width: width - 100,
                      child: Text(
                        t.notifications_expiring_soon_body,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 20,
                    child: Text(t.notifications_time_9d),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
