import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:siklero_admin/screens/bikefailures_records_screen.dart';
import 'package:siklero_admin/screens/manage_admins_screen.dart';
import 'package:siklero_admin/screens/manage_users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 50,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFFE45F1E), //E45F1E
          child: const Icon(
            Icons.settings,
            size: 45,
          ),
        ),
      ),
      backgroundColor: Color(0xFFED8F5B),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: 40, left: 30.0, right: 0.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage(
                      'images/siklero-logo.png',
                    ),
                    height: 130.0,
                  ),
                ),
                Hero(
                  tag: 'red-ribbon',
                  child: Container(
                    //margin: EdgeInsets.only(left: 30),
                    child: const Image(
                      image: AssetImage(
                        'images/red-ribbon.png',
                      ),
                      height: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  ReusableCard(
                    recordedNumber: '15',
                    description: 'Bicycle Failures Recorded',
                    function: 'view',
                    imagePath: 'images/repair-icon.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BikeRecordsScreen(),
                          ));
                    },
                  ),
                  ReusableCard(
                    recordedNumber: '24',
                    description: 'Regular (?) Users',
                    function: 'manage',
                    imagePath: 'images/user-icon.png',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageUsers(),
                          ));
                    },
                  ),
                  // ReusableCard(
                  //   recordedNumber: '4',
                  //   description: 'Admin Users',
                  //   function: 'manage',
                  //   imagePath: 'images/user-icon.png',
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ManageAdmins(),
                  //         ));
                  //   },
                  // ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String recordedNumber;
  final String description;
  final String function;
  final String imagePath;
  final VoidCallback onPressed;

  ReusableCard(
      {required this.recordedNumber,
      required this.description,
      required this.function,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(bottom: 0),
      margin: EdgeInsets.only(top: 10.0, bottom: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFFFD4BC),
      ),
      //padding: EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(left: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    recordedNumber,
                    style: const TextStyle(
                      letterSpacing: -5,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 80.0,
                      color: Color(0xFF581D00),
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                      color: Color(0xFF581D00),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(top: 20, left: 20),
                    margin: EdgeInsets.only(top: 20),
                    child: Image(
                      image: AssetImage(
                        imagePath,
                      ),
                      height: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 1.0,
            width: 400.0,
            child: Divider(
              color: Color(0xFFED8F5B),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    function,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF581D00),
                    ),
                  ),
                  GestureDetector(
                    onTap: onPressed,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
