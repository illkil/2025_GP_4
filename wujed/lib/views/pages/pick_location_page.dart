import 'package:flutter/material.dart';
import 'package:wujed/widgets/bottom_sheet_widget.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  screenTapped() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => BottomSheetWidget(page: 'PickLocationPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/Maps.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              // Return a chosen location to the caller
              Navigator.pop(context, {
                'lat': 24.7136,
                'lng': 46.6753,
                'address': 'King Saud University, Riyadh',
              });
            },
            onVerticalDragStart: (details) {
              Navigator.pop(context, {
                'lat': 24.7136,
                'lng': 46.6753,
                'address': 'King Saud University, Riyadh',
              });
            },
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:wujed/widgets/bottom_sheet_widget.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  screenTapped() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => BottomSheetWidget(page: 'PickLocationPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/Maps.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              screenTapped();
            },
            onVerticalDragStart: (details) {
              screenTapped();
            },
          ),
        ],
      ),
    );
  }
}*/
