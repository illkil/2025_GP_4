import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:remixicon/remixicon.dart';
import 'package:wujed/views/pages/chat_location_page.dart';
import 'package:wujed/widgets/chat_bubble.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.location});

  final bool location;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _location = false;

  @override
  void initState() {
    super.initState();
    _location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: const Text(
            'Ghaida44',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              reverse: true,
              children: [
                if (_location)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE4B3),
                          borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(18),
                            topEnd: Radius.circular(18),
                            bottomStart: Radius.circular(18),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              'lib/assets/images/ChatMap.png',
                              width: 255,
                              height: 160,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '9:39 PM',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 3.0),
                                Icon(
                                  Remix.check_double_line,
                                  size: 18,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ChatBubble(
                  text: t.chat_great_do,
                  time: '9:39 PM',
                  isSender: true,
                  isRead: false,
                ),
                ChatBubble(
                  text: t.chat_lets_decide,
                  time: '9:35 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text: t.chat_yes_match,
                  time: '9:35 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text: t.chat_hello,
                  time: '9:34 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text: t.chat_id_request,
                  time: '9:30 PM',
                  isSender: true,
                  isRead: true,
                ),
                ChatBubble(
                  text: t.chat_hello,
                  time: '9:24 PM',
                  isSender: true,
                  isRead: true,
                ),

                SizedBox(height: 20),

                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(t.chat_date),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 110.0,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push<Map<String, dynamic>>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatLocationPage(),
                        ),
                      );
                      if (result?['location'] == true) {
                        setState(() => _location = true);
                      }
                    },
                    icon: Icon(
                      Remix.attachment_line,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: t.chat_hint,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Transform.rotate(
                      angle: 0.8,
                      child: const Icon(
                        IconlyBold.send,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
