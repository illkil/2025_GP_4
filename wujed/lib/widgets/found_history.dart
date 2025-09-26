import 'package:flutter/material.dart';
import 'package:wujed/views/pages/item_reported_found.dart';

class FoundHistory extends StatefulWidget {
  const FoundHistory({super.key});

  @override
  State<FoundHistory> createState() => _FoundHistoryState();
}

class _FoundHistoryState extends State<FoundHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100.0,
          width: 360.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.0,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'lib/assets/images/CoffeeBrew2.jpg',
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 95,
                          child: Text(
                            'Coffee Brewer',
                            style: TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '1 January 2025',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 57,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: Color.fromRGBO(255, 204, 92, 1),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Ongoing',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 204, 92, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ItemReportedFound();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    
        SizedBox(height: 15.0),
    
        Container(
          height: 100.0,
          width: 360.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.0,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.image,
                            size: 50.0,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 95,
                          child: Text(
                            'Item2',
                            style: TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '1 January 2000',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 57,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: Color.fromRGBO(25, 176, 0, 1),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Done',
                                style: TextStyle(
                                  color: Color.fromRGBO(25, 176, 0, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    
        SizedBox(height: 15.0),
    
        Container(
          height: 100.0,
          width: 360.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
    
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.0,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.image,
                            size: 50.0,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 95,
                          child: Text(
                            'Item3',
                            style: TextStyle(
                              color: Color.fromRGBO(46, 23, 21, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '1 January 2000',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 57,
                          left: 95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: Color.fromRGBO(211, 47, 47, 1),
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Rejected',
                                style: TextStyle(
                                  color: Color.fromRGBO(211, 47, 47, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
