import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/widgets/blocked_users_row.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.blocked_users,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          BlockedUsersRow(name: '@Ghaida45'),
          BlockedUsersRow(name: '@AhlamQ'),
          BlockedUsersRow(name: '@Ghena123'),
          BlockedUsersRow(name: '@almunyifjwhert'),
        ],
      ),
    );
  }
}
