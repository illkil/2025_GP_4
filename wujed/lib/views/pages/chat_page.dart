import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:remixicon/remixicon.dart';
import 'package:wujed/views/pages/chat_location_page.dart';
import 'package:wujed/widgets/chat_bubble.dart';

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
    _location = widget.location; // initial value if passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
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
                          color: Color(0xFFFFE4B3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
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
                                SizedBox(width: 3.0),
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
                  text: 'Great! Let\'s do',
                  time: '9:39 PM',
                  isSender: true,
                  isRead: false,
                ),
                ChatBubble(
                  text: 'Let\'s decide on a place and time to meet!',
                  time: '9:35 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text: 'Yes in fact it does match',
                  time: '9:35 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text: 'Hello!',
                  time: '9:34 PM',
                  isSender: false,
                  isRead: true,
                ),
                ChatBubble(
                  text:
                      'That sounds like mine. Inside there should be a student ID with the name Ghaida Mo Can you check if it matches?',
                  time: '9:30 PM',
                  isSender: true,
                  isRead: true,
                ),
                ChatBubble(
                  text: 'Hello!',
                  time: '9:24 PM',
                  isSender: true,
                  isRead: true,
                ),
              ],
            ),
          ),

          Container(
            height: 110.0,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push<Map<String, dynamic>>(
                        context,
                        MaterialPageRoute(builder: (_) => ChatLocationPage()),
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
                      decoration: InputDecoration(
                        hintText: 'Type Your Message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
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
                      child: Icon(
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
