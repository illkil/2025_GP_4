import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
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
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          t.messages_title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatPage(location: false);
                  },
                ),
              );
            },
            child: MessageTile(
              name: 'Ghaida44',
              subtitle: "${t.messages_you_prefix} ${t.chat_great_do}",
              time: '09:46 PM',
              check: true,
            ),
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'AhlamQ',
            subtitle: t.chat_hello_found_item,
            time: '09:46 PM',
            check: true,
            doubleTick: true,
            dotColor: const Color(0xFFFF0000),
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'Ghena123',
            subtitle: t.messages_typing,
            time: '09:46 PM',
            check: true,
            doubleTick: true,
            doubleTickGreen: true,
          ),

          SizedBox(height: 10.0),

          MessageTile(
            name: 'almunyifjwhrt',
            subtitle: t.messages_items_matched,
            time: '',
            dotColor: const Color(0xFF006FFF),
          ),
        ],
      ),
    );
  }
}
