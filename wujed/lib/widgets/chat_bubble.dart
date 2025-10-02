import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String time;
  final bool isRead;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSender ? const Color(0xFFFFE4B3) : Colors.grey.shade200;
    final checkColor = isRead
        ? const Color.fromRGBO(25, 176, 0, 1)
        : Colors.grey.shade600;
    final textColor = Colors.black;
    final align = isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isSender
        ? const BorderRadiusDirectional.only(
            topStart: Radius.circular(18),
            topEnd: Radius.circular(18),
            bottomStart: Radius.circular(18),
          )
        : const BorderRadiusDirectional.only(
            topStart: Radius.circular(18),
            topEnd: Radius.circular(18),
            bottomEnd: Radius.circular(18),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(color: bgColor, borderRadius: radius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text, style: TextStyle(color: textColor, fontSize: 16)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  SizedBox(width: 3.0),
                  Icon(Remix.check_double_line, size: 18, color: checkColor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
