import 'package:flutter/material.dart';
import 'package:wujed/views/pages/pick_location_page.dart';
import 'package:wujed/views/pages/submit_successfully_page.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ReportLostPage extends StatefulWidget {
  const ReportLostPage({super.key});

  @override
  State<ReportLostPage> createState() => _ReportLostPageState();
}

class _ReportLostPageState extends State<ReportLostPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  Color textColor = Colors.grey.shade600;
  Widget? uploadPhoto;

  final int _maxLength = 300;

  @override
  void initState() {
    super.initState();
    uploadPhoto = buildUploadButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    color: Color.fromRGBO(46, 23, 21, 1),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                'Report A Lost Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),

              SizedBox(height: 10.0),

              Text(
                'Please fill all required details',
                style: TextStyle(fontSize: 16.0, color: textColor),
              ),

              SizedBox(height: 40.0),

              Row(
                children: [
                  Text(
                    'Title ',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Color.fromRGBO(211, 47, 47, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              TextField(
                controller: controllerTitle,
                decoration: InputDecoration(
                  hintText: 'Example: Brown  wallet',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      width: 2.0,
                    ),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Photo ',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Color.fromRGBO(211, 47, 47, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              uploadPhoto!,

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PickLocationPage();
                      },
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: SizedBox(
                  height: 55.0,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment(-1, 0),
                        child: Icon(
                          IconlyBold.location,
                          color: Color.fromRGBO(46, 23, 21, 1),
                          size: 37,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.3, 0),
                        child: Text(
                          'Click here to add a Location',
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

              Row(
                children: [
                  Text(
                    'Description ',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Color.fromRGBO(211, 47, 47, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              TextField(
                controller: controllerDescription,
                maxLength: _maxLength,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Describe your item (Type, Color, Brand, etc)',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      width: 2.0,
                    ),
                  ),
                  counterText:
                      '${_maxLength - controllerDescription.text.length} characters left',
                  counterStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),

              SizedBox(height: 30.0),

              FilledButton(
                onPressed: () {
                  onSubmitPressed();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  buildUploadButton() {
    return OutlinedButton(
      onPressed: () {
        onUploadPhoto();
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: SizedBox(
        height: 55.0,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment(-1, 0),
              child: Icon(
                IconlyBold.camera,
                color: Color.fromRGBO(46, 23, 21, 1),
                size: 37,
              ),
            ),
            Align(
              alignment: Alignment(0.3, 0),
              child: Text(
                'Click here to add up to 2 Photos',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onUploadPhoto() {
    setState(() {
      uploadPhoto = Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'lib/assets/images/CoffeeBrew.WEBP',
                height: 160,
                width: 160,
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(
                  IconlyBold.camera,
                  color: Color.fromRGBO(46, 23, 21, 1),
                  size: 37,
                ),
                onPressed: () {
                  onIconButtonPressed();
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  onIconButtonPressed() {
    setState(() {
      uploadPhoto = Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                  ),
                  child: Image.asset(
                    'lib/assets/images/CoffeeBrew.WEBP',
                    height: 160,
                    width: 160,
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(17),
                    bottomRight: Radius.circular(17),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'lib/assets/images/CoffeeBrew2.jpg',
                    height: 160,
                    width: 160,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void onSubmitPressed() {
    final title = controllerTitle.text.trim();
    final description = controllerDescription.text;

    if (title.isEmpty || description.isEmpty) {
      setState(() {
        textColor = Color.fromRGBO(211, 47, 47, 1);
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SubmitSuccessfullyPage();
          },
        ),
        (route) => false,
      );
    }
  }
}
