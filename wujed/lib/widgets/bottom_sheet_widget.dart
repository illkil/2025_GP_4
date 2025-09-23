import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 320.0,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            SizedBox(height: 15.0),

            Text(
              'Choose a Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Color.fromRGBO(46, 23, 21, 1),
              ),
            ),

            SizedBox(height: 20.0),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 70.0,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment(-1.05, 0),
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 45,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.3, -0.5),
                      child: Text(
                        'Your current location',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.6, 0.5),
                      child: Text(
                        'King Saud University, Riyadh 12372',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 70.0,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment(-1.05, 0),
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 45,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.4, 0),
                      child: Text(
                        'Choose Manually',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
