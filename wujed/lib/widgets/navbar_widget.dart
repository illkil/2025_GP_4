import 'package:flutter/material.dart';
import 'package:wujed/data/notifiers.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

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
              iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
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
                  icon: const Icon(IconlyBold.home, size: 30),
                  label: t.navbar_home,
                ),
                NavigationDestination(
                  icon: const Icon(IconlyBold.timeCircle, size: 30),
                  label: t.navbar_history,
                ),
                NavigationDestination(
                  icon: Stack(
                    children: [
                      const Icon(IconlyBold.message, size: 30),
                      const PositionedDirectional(
                        end: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.circle,
                          color: Color.fromRGBO(255, 0, 0, 1),
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  label: t.navbar_messages,
                ),
                NavigationDestination(
                  icon: const Icon(IconlyBold.profile, size: 30),
                  label: t.navbar_profile,
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
