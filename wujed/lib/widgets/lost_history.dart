import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wujed/services/report_service.dart';
import 'package:wujed/views/pages/item_reported_lost.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:wujed/utils/dialogs.dart';

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

String statusToText(AppLocalizations t, String raw) {
  switch (raw.toLowerCase()) {
    case 'ongoing':
      return t.status_ongoing;
    case 'done':
      return t.status_done;
    case 'rejected':
      return t.status_rejected;
    case 'match_found':
      return t.status_match_found;
    case 'expired':
      return t.status_expired;
    default:
      return raw;
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
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(255, 175, 0, 1),
            ),
          );
        }

        //2. if error
        if (snapshot.hasError) {
          return Center(child: Text(t.common_error_generic));
        }

        //3. if no data is returned (empty)
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return Center(child: Text(t.history_no_lost_reports));
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
                : t.common_untitled;

            final ts = data['createdAt'] as Timestamp?;
            final date = ts?.toDate() ?? DateTime.now();

            final status = data['status'] as String?;
            final color = statusToColor(status!);

            final rejectReason = data['rejectReason'] as String?;

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
                  rejectReason,
                  doc.id,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget historyItem(
  BuildContext context,
  String title,
  DateTime date,
  String status,
  Color color, [
  String? imageUrl,
  String? rejectReason,
  String? reportId,
]) {
  final t = AppLocalizations.of(context);

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.05),
          offset: const Offset(0, 4),
          blurRadius: 16,
        ),
      ],
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ---------------- LEFT: IMAGE ----------------
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.2),
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
                      size: 40,
                      color: Colors.grey.shade400,
                    ),
                  )
                : Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              // DATE
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    formatDate(context, date),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // STATUS
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: color,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    statusToText(t, status),
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // ---------------- REJECTION MESSAGE ----------------
              if (status.toLowerCase() == 'rejected' && rejectReason != null) ...[
                const SizedBox(height: 6),
                Text(
                  mapRejectReasonToMessage(
                    context,
                    rejectReason,
                    'lost',
                  ),
                  style: TextStyle(
                    color: Colors.red.shade300,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemReportedLost(reportId: reportId!),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ),
      ],
    ),
  );
}
}
