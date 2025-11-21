import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:remixicon/remixicon.dart';

// Page used to pick / send a meeting location in chat
import 'package:wujed/views/pages/chat_location_page.dart';

// Custom widget that draws a single chat bubble
import 'package:wujed/widgets/chat_bubble.dart';

// Localization (Arabic / English texts)
import 'package:wujed/l10n/generated/app_localizations.dart';

// Global notifier that controls the bottom navigation selected page
import 'package:wujed/data/notifiers.dart';

/// Chat screen between the current user and another user.
///
/// `location` → whether we should show the map bubble when opening the page.
/// `name`     → other user's name ("Ghaida44", etc.).
class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.location,
    required this.name,
  });

  final bool location;
  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /// Local flag to decide if we show the location bubble.
  bool _location = false;

  @override
  void initState() {
    super.initState();
    // Get the initial value from the widget param
    _location = widget.location;
  }

  /// Returns the list of message widgets depending on who the other user is.
  ///
  /// Right now our "chat" is static and hard-coded just for the prototype.
  /// Later this can be replaced with messages from Firestore / backend.
  List<Widget> _buildMessagesForUser(String name, AppLocalizations t) {
    // 1) Special case: system message when items are matched
    if (name == 'MatchedUser1') {
      return [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD7EBFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              t.messages_items_matched,
              style: const TextStyle(
                color: Color(0xFF007BFF),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ];
    }

    // 2) Pre-designed conversation with user "Ghaida44"
    if (name == 'Ghaida44') {
      return [
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
      ];
    }

    // 3) Default messages for any other user
    return [
      ChatBubble(
        text: 'Hi there!',
        time: '9:00 AM',
        isSender: false,
        isRead: true,
      ),
      ChatBubble(
        text: 'Hello!',
        time: '9:01 AM',
        isSender: true,
        isRead: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return WillPopScope(
      // Handle Android back button: go back to main page tab instead of
      // stacking multiple copies of HomePage.
      onWillPop: () async {
        selectedPageNotifier.value = 2; // 2 = messages tab (in your app)
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false; // we already handled the back navigation
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Same behaviour as Android back button: return to main page.
              selectedPageNotifier.value = 2;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          title: Title(
            color: const Color.fromRGBO(46, 23, 21, 1),
            child: Text(
              widget.name, // show other user's name
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          // Dismiss keyboard when user taps anywhere outside the input field
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ---------------- MESSAGES LIST ----------------
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  reverse: true, // latest messages at the bottom
                  children: [
                    // Optional location bubble (map snapshot)
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
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFE4B3),
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(18),
                                topEnd: Radius.circular(18),
                                bottomStart: Radius.circular(18),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Static image of the map preview
                                Image.asset(
                                  'lib/assets/images/ChatMap.png',
                                  width: 255,
                                  height: 160,
                                ),
                                const SizedBox(height: 4),
                                // Time + double-check icon
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

                    // Static bubbles based on which user we're chatting with
                    ..._buildMessagesForUser(widget.name, t),

                    const SizedBox(height: 20),

                    // Date separator (e.g., "Today")
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

              // ---------------- MESSAGE INPUT AREA ----------------
              Container(
                height: 110.0,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Attachment / location button
                      IconButton(
                        onPressed: () async {
                          // Navigate to page where user selects meeting place.
                          final result =
                              await Navigator.push<Map<String, dynamic>>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatLocationPage(),
                            ),
                          );

                          // If user chose to send location, show the map bubble.
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

                      // Text input for typing message (currently not saved)
                      Expanded(
                        child: Container(
                          height: 40,
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
                            onEditingComplete: () {
                              // Hide keyboard when user presses "done"
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ),

                      // Send button (currently only visual – logic will be added
                      // when real chat backend is implemented).
                      IconButton(
                        onPressed: () {
                          // TODO: connect to real send logic (Firestore / backend)
                        },
                        icon: Transform.rotate(
                          angle: 0.8, // rotate to look like a paper plane
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
        ),
      ),
    );
  }
}
