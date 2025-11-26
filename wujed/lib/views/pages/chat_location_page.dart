import 'package:flutter/material.dart';
import 'package:wujed/widgets/bottom_sheet_widget.dart';

class ChatLocationPage extends StatefulWidget {
  const ChatLocationPage({super.key});

  @override
  State<ChatLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<ChatLocationPage> {
  void screenTapped() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (ctx) => BottomSheetWidget(page: 'ChatLocationPage'),
    );

    if (result == 'current' || result == 'manual') {
      Navigator.pop(context, 'choosed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/Maps.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              screenTapped();
            },
            onVerticalDragStart: (details) {
              screenTapped();
            },
          ),
        ],
      ),
    );
  }
}
