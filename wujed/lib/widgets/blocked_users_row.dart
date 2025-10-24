import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class BlockedUsersRow extends StatelessWidget {
  const BlockedUsersRow({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 12,
            start: 10,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    IconlyBold.profile,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 20,
            start: 70,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(46, 23, 21, 1),
              ),
            ),
          ),
          PositionedDirectional(
            top: 5,
            end: 10,
            child: Container(
              child: FilledButton(
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
                      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.unblock_dialog_title,
                            style: const TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: Text(
                        t.unblock_user_confirm(name),
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.end,
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  //unblok logic here
                                  Navigator.pop(context);
                                },
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
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
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size(35, 35),
                  backgroundColor: const Color.fromRGBO(166, 91, 91, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  t.unblock_user,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
