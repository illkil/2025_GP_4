import 'package:flutter/material.dart';
import 'package:wujed/widgets/found_history.dart';
import 'package:wujed/widgets/lost_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            'History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = 0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? Color.fromRGBO(46, 23, 21, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Lost',
                          style: TextStyle(
                            color: selectedIndex == 0
                                ? Colors.white
                                : Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: selectedIndex == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = 1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? Color.fromRGBO(46, 23, 21, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Found',
                          style: TextStyle(
                            color: selectedIndex == 1
                                ? Colors.white
                                : Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: selectedIndex == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: selectedIndex == 0 ? LostHistory() : FoundHistory(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
