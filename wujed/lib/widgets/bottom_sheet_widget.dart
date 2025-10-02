import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 320.0,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 15.0),

            Text(
              t.sheet_choose_location_title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color.fromRGBO(46, 23, 21, 1),
              ),
            ),

            const SizedBox(height: 20.0),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 70.0,
                width: double.infinity,
                child: Stack(
                  children: [
                    const PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 45,
                      ),
                    ),
                    PositionedDirectional(
                      top: 15,
                      start: 60,
                      child: Text(
                        t.sheet_current_location_title,
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    PositionedDirectional(
                      top: 35,
                      start: 60,
                      child: Text(
                        t.sheet_current_location_sub,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 70.0,
                width: double.infinity,
                child: Stack(
                  children: [
                    const PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 45,
                      ),
                    ),
                    PositionedDirectional(
                      top: 25,
                      start: 60,
                      child: Text(
                        t.sheet_choose_manually,
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, {'location': true});
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                page == 'PickLocationPage'
                    ? t.sheet_confirm
                    : t.sheet_send,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
