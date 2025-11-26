import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/services/chat_store.dart';
import 'package:wujed/views/pages/chat_page.dart';
import 'package:wujed/services/match_store.dart';
import 'package:wujed/views/pages/match_after_accepting_page.dart';

class MatchDetailsPage extends StatefulWidget {
  final String reportId;

  const MatchDetailsPage({super.key, required this.reportId});

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
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
            t.item_title_coffee_brewer,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('lib/assets/images/CoffeeBrew2.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Row(
                children: [
                  Text(
                    t.details_location_label,
                    style: const TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    const PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      start: 20,
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 37,
                      ),
                    ),
                    const PositionedDirectional(
                      top: 18,
                      start: 100,
                      child: Text(
                        'XYZLOCATIONXYZXYZXYZ',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      end: 10,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: Color.fromRGBO(46, 23, 21, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    t.details_description_label,
                    style: const TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 169,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                    style: TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        final confirmed = await showDialog<String>(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            alignment: Alignment.center,
                            titlePadding: const EdgeInsets.fromLTRB(
                              20,
                              20,
                              20,
                              0,
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                              20,
                              10,
                              20,
                              20,
                            ),
                            actionsPadding: const EdgeInsets.fromLTRB(
                              20,
                              0,
                              20,
                              20,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.dialog_are_you_sure_item,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              t.dialog_accept_match_note,
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.end,
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Confirm');
                                },
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  backgroundColor: const Color.fromRGBO(
                                    46,
                                    23,
                                    21,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  t.btn_confirm,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  t.btn_cancel,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == 'Confirm') {
                          if (!context.mounted) return;

                          const String matchedUser = 'MatchedUser1';
                          final String reportId = widget.reportId;

                          // 1) mark this match as accepted
                          MatchStore.instance.accept(reportId);
                          ChatStore.instance.addUser(matchedUser);

                          // 2) REPLACE MatchDetails with MatchAfterAccepting
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MatchAfterAcceptingPage(
                                reportId: reportId,
                                openChatInitially: true,
                              ),
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(170, 45),
                        backgroundColor: const Color.fromRGBO(101, 166, 91, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        t.btn_accept,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        final confirmed = await showDialog<String>(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            alignment: Alignment.center,
                            titlePadding: const EdgeInsets.fromLTRB(
                              20,
                              20,
                              20,
                              0,
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                              20,
                              10,
                              20,
                              20,
                            ),
                            actionsPadding: const EdgeInsets.fromLTRB(
                              20,
                              0,
                              20,
                              20,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.dialog_are_you_sure,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              t.dialog_remove_permanently_note,
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.end,
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Confirm');
                                },
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  backgroundColor: const Color.fromRGBO(
                                    46,
                                    23,
                                    21,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  t.btn_confirm,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  t.btn_cancel,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == 'Confirm') {
                          if (!context.mounted) return;
                          Navigator.pop(context, 'Rejected');
                          print('Reject tapped');
                        }
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(170, 45),
                        backgroundColor: const Color.fromRGBO(166, 91, 91, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        t.btn_reject,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
