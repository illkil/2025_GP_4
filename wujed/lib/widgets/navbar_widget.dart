import 'package:flutter/material.dart';
import 'package:wujed/data/notifiers.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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
                  icon: Icon(IconlyBold.home, size: 30),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(IconlyBold.timeCircle, size: 30),
                  label: 'History',
                ),
                NavigationDestination(
                  icon: Stack(
                    children: [
                      Icon(IconlyBold.message, size: 30),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.circle,
                          color: Color.fromRGBO(255, 0, 0, 1),
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  label: 'Messages',
                ),
                NavigationDestination(
                  icon: Icon(IconlyBold.profile, size: 30),
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
