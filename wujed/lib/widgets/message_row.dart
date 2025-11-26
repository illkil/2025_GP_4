import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:remixicon/remixicon.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({
    super.key,
    required this.name,
    required this.subtitle,
    required this.time,
    this.check = false,
    this.doubleTick = false,
    this.doubleTickGreen = false,
    this.dotColor,
  });

  final String name;
  final String subtitle;
  final String time;
  final bool check;
  final bool doubleTick;
  final bool doubleTickGreen;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final haveCheck = check
        ? (doubleTick ? Remix.check_double_line : Remix.check_line)
        : null;
    final checkIcon = doubleTick ? Remix.check_double_line : Remix.check_line;

    final checkColor = doubleTickGreen
        ? const Color.fromRGBO(25, 176, 0, 1)
        : Colors.grey.shade600;

    final isItemsMatched = subtitle == t.messages_items_matched;

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.26,
        children: [
          SlidableAction(
            onPressed: (_) {
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
                        t.block_dialog_title,
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Text(
                    t.block_user_confirm(name),
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
            backgroundColor: const Color(0xFFFFE5E5),
            foregroundColor: const Color(0xFFE53935),
            label: t.action_block,
            autoClose: true,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 249, 249, 1),
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 12,
              start: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Icon(
                      IconlyBold.profile,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  if (dotColor != null)
                    PositionedDirectional(
                      bottom: -2,
                      end: -2,
                      child: Icon(Icons.circle, color: dotColor, size: 14),
                    ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 15,
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
              top: 40,
              start: 70,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isItemsMatched
                      ? const Color.fromRGBO(0, 111, 255, 1)
                      : Colors.grey.shade600,
                  fontWeight: isItemsMatched
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (haveCheck != null)
              PositionedDirectional(
                top: 25,
                end: 0,
                child: Row(
                  children: [
                    Icon(checkIcon, color: checkColor, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
