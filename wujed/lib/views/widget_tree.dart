import 'package:flutter/material.dart';
import 'package:wujed/data/notifiers.dart';
import 'package:wujed/views/pages/history_page.dart';
import 'package:wujed/views/pages/home_page.dart';
import 'package:wujed/views/pages/messages_page.dart';
import 'package:wujed/views/pages/profile_page.dart';
import 'package:wujed/widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(), HistoryPage(), MessagesPage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
