import 'dart:ui';
import 'package:flutter/material.dart';
import 'editprofile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siklero_admin/models/users.dart';

//print(user.address);
final _firestore = FirebaseFirestore.instance;

const kUserLabelTextStyle = TextStyle(
    fontFamily: 'OpenSansCondensed', fontWeight: FontWeight.w300, fontSize: 16);

class ManageUsers extends StatelessWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Manage Users',
            style: TextStyle(
                color: Color(0xFF581D00),
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFFED8F5B),
        body: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40,
                  margin: EdgeInsets.fromLTRB(180, 16, 30, 16),
                  child: TextField(
                    //controller: searchController,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: TextStyle(fontSize: 15, color: Color(0xFFE45F1E)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFD4BC),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 17,
                        color: Color(0xFFE45F1E),
                      ),
                      hintText: 'Search',
                      hintStyle: (const TextStyle(
                        fontSize: 15,
                        color: Color(0xFFE45F1E),
                      )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFFE45F1E),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFFE45F1E),
                        ),
                      ),
                    ),
                  ),
                ),
                UsersStream(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsersStream extends StatelessWidget {
  const UsersStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('user_profile').snapshots(), //collection
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final users = snapshot.data?.docs.reversed;
        List<UsersCard> userCards = [];
        int counter = 0;
        for (var user in users!) {
          final userAddress = user.get('address');
          final userEmail = user.get('username');
          final userfName = user.get('first_name');
          final userlName = user.get('last_name');
          final userNumber = user.get('contact');
          final userID = user.id;

          //final numberCard =
          counter++;
          final userCard = UsersCard(
            fName: userfName,
            lName: userlName,
            email: userEmail,
            number: userNumber,
            address: userAddress,
            counter: counter,
            userID: userID,
          );
          userCards.add(userCard);
        }
        print(userCards);
        return Expanded(
            child: ListView(
          //reverse: true,
          children: userCards,
        ));
      },
    );
  }
}

class UsersCard extends StatelessWidget {
  UsersCard(
      {required this.fName,
      required this.lName,
      required this.email,
      required this.number,
      required this.address,
      required this.counter,
      required this.userID});

  final String address;
  final String email;
  final String fName;
  final String lName;
  final String number;
  int counter;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xFFFFD4BC)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage('images/user-icon.png'),
                  height: 60,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFED8F5B),
                          ),
                          child: Center(
                            child: Text(
                              '0${counter}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          //color: Color(0xFFED8F5B),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                  address: address,
                                  email: email,
                                  fName: fName,
                                  lName: lName,
                                  number: number,
                                  userID: userID),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 69,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFE45F1E)),
                            child: const Center(
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${fName}',
                      style: const TextStyle(
                        fontFamily: 'OpenSansCondensed',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      '${lName}',
                      style: const TextStyle(
                        fontFamily: 'OpenSansCondensed',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
              width: 400.0,
              child: Divider(
                color: Color(0xFF581D00),
                thickness: 1,
              ),
            ),
            Text('Email: ${email}', style: kUserLabelTextStyle),
            Text('Contact Number: ${number}', style: kUserLabelTextStyle),
            Text('Address: ${address}', style: kUserLabelTextStyle),
          ],
        ));
  }
}
