import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:siklero_admin/screens/bikefailures_records_screen.dart';
import 'package:siklero_admin/screens/login_screen.dart';
import 'package:siklero_admin/screens/manage_admins_screen.dart';
import 'package:siklero_admin/screens/manage_users_screen.dart';

import 'editprofile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 50,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => buildSheet(),
            );
          },
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
                EdgeInsets.only(top: 70, left: 30.0, right: 0.0, bottom: 40.0),
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
                    description: 'Bicycle Failures Records',
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
                    description: 'Regular Users',
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

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildSheet() {
    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          minChildSize: 0.3,
          builder: (_, controller) => Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  controller: controller,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Image(
                          image: AssetImage('images/user-icon.png'),
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                'ss89as967sh',
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 24,
                                    color: Color(0xff581D00)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Jonathan Doe',
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 24,
                                    color: Color(0xff581D00)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        InfoText(
                            title: 'Contact#', data: '09669978081', maxLine: 1),
                        InfoText(
                            title: 'Address',
                            data: 'This is an Address',
                            maxLine: 3)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: EditButton(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: LogoutButton(),
                    )
                  ],
                ),
              )),
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
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFFFD4BC),
      ),
      //padding: EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
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
                      fontSize: 70.0,
                      color: Color(0xFF581D00),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        color: Color(0xFF581D00),
                      ),
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

class InfoText extends StatelessWidget {
  const InfoText({
    Key? key,
    required this.title,
    required this.data,
    required this.maxLine,
  }) : super(key: key);

  final String title;
  final String data;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
        fontFamily: 'OpenSans', fontSize: 24, color: Color(0xff581D00));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Text(
            data,
            style: textStyle,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  /*
  const LogoutButton({
    Key? key,
    required this.context,
    required this.user,
  }) : super(key: key);

  final BuildContext context;
  final User user; */

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //FirebaseAuth.instance.signOut();

          //print(user.uid);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LogInScreen()),
              (route) => false);
        },
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xffe45f1e)),
        child: const Text(
          'Log Out',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ));
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          ));
        },
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xffe45f1e)),
        child: const Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ));
  }
}

/*

Future<UserData?> readUser() async {
  final docUser =
      FirebaseFirestore.instance.collection('user_profile').doc(user.uid);
  final userSnapShot = await docUser.get();

  if (userSnapShot.exists) {
    return UserData.fromJSON(userSnapShot.data()!);
  }

  return null;
}
/*
Future checkSOSCall() async {
  await FirebaseFirestore.instance
      .collection('sos_call')
      .where('user_id', isEqualTo: user.uid)
      .where('is_active', isEqualTo: true)
      .limit(1)
      .get()
      .then((QuerySnapshot querySnapshot) => {
            if (querySnapshot.docs.isEmpty)
              {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SOSDetailsScreen(userInfo: userData),
                ))
              }
            else
              {
                querySnapshot.docs.forEach((doc) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SOSCallScreen(sosID: doc.id),
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'You have a SOS Call currently active, please Cancel SOS to create a new one',
                    style: TextStyle(color: Colors.redAccent),
                  )));
                })
              }
          });
}
*/
*/
