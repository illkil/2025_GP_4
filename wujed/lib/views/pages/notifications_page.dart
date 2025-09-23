import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Row(
                      children: [
                        Text(
                          'Report Expired ',
                          style: TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      'your report of Item5 has expired\ndue  to unconfirmed receipt.',style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(right: 20, child: Text('2 days ago')),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Row(
                      children: [
                        Text(
                          'New Match Found',
                          style: TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      'A new match has been found for\nyour report of Coffee Brewer.',style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(right: 20, child: Text('6 days ago')),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: Row(
                      children: [
                        Text(
                          'Report Expiring Soon ',
                          style: TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      'Your report of Coffee Brewer will\nexpire in 5 days unless you renew it\nor accept a match.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(right: 20, child: Text('9 days ago')),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
