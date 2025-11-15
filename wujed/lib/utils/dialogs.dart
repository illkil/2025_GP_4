import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

Future<void> showAppDialog(
  BuildContext context,
  String title,
  String message,
) async {
  final t = AppLocalizations.of(context);

  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      alignment: Alignment.center,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromRGBO(46, 23, 21, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      content: Text(message, textAlign: TextAlign.center),

      actionsAlignment: MainAxisAlignment.end,
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
            backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            t.btn_ok,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

//Rejection messsage for the user
  String mapRejectReasonToMessage(context, String? reason, String type) {
    final t = AppLocalizations.of(context);
    if (reason == null) {
      return t.couldnt_process;
    }

    switch (reason) {
      case 'junk_description':
       return t.describe_clearly;
      case 'no_objects_detected':
        return t.image_unclear;
      default:
        return t.couldnt_process;
    }
  }