import 'package:flutter/material.dart';
import 'package:wujed/widgets/message_row.dart';
import 'package:wujed/views/pages/chat_page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatPage(location: false,);
              },));
            },
            child: MessageTile(
              name: 'Ghaida44',
              subtitle: "You: Great! Let's do",
              time: '09:46 PM',
              check: true,
            ),
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'AhlamQ',
            subtitle: 'Hello, I think I found your item',
            time: '09:46 PM',
              check: true,
            doubleTick: true,
            dotColor: const Color(0xFFFF0000),
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'Ghena123',
            subtitle: 'Typing...',
            time: '09:46 PM',
              check: true,
            doubleTick: true,
            doubleTickGreen: true,
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'almunyifjwhrt',
            subtitle: 'Your Items Matched!',
            time: '',
            dotColor: const Color(0xFF006FFF),
          ),
        ],
      ),
    );
  }
}
