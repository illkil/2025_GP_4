import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:remixicon/remixicon.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
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
    final haveCheck = check ? (doubleTick ? Remix.check_double_line : Remix.check_line) : null ;
    final checkIcon = doubleTick ? Remix.check_double_line : Remix.check_line;

    final checkColor = doubleTickGreen
        ? const Color.fromRGBO(25, 176, 0, 1)
        : Colors.grey.shade600;

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.26,
        children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFFFE5E5),
            foregroundColor: const Color(0xFFE53935),
            label: 'Block',
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
            Positioned(
              top: 12,
              left: 0,
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
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Icon(Icons.circle, color: dotColor, size: 14),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 15,
              left: 70,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 70,
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: subtitle == 'Your Items Matched!'
                      ? const Color.fromRGBO(0, 111, 255, 1)
                      : Colors.grey.shade600,
                  fontWeight: subtitle == 'Your Items Matched!'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            
            if(haveCheck != null)
            Positioned(
              top: 25,
              right: 0,
              child: Row(
                children: [
                  Icon(checkIcon, color: checkColor, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
