import 'package:flutter/material.dart';
import 'package:wujed/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.transparent,
              iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return const IconThemeData(
                    color: Color.fromRGBO(46, 23, 21, 1),
                  );
                }
                return const IconThemeData(color: Colors.grey);
              }),
            ),
            child: NavigationBar(
              backgroundColor: Colors.white,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_rounded, size: 30),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_rounded, size: 30),
                  label: 'History',
                ),
                NavigationDestination(
                  icon: Icon(Icons.email_rounded, size: 30),
                  label: 'Messages',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_rounded, size: 30),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (int value) {
                selectedPageNotifier.value = value;
              },
              selectedIndex: selectedPage,
            ),
          ),
        );
      },
    );
  }
}
