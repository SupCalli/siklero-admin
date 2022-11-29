import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kUserDetailsTextStyle = TextStyle(
    fontFamily: 'OpenSansCondensed',
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: Color(0xFF581D00));

const kUserLabelTextStyle = TextStyle(
    fontFamily: 'OpenSansCondensed',
    fontWeight: FontWeight.w300,
    fontSize: 15,
    color: Color(0xFF581D00));

class BikeRecordsScreen extends StatefulWidget {
  const BikeRecordsScreen({Key? key}) : super(key: key);

  @override
  State<BikeRecordsScreen> createState() => _BikeRecordsScreenState();
}

class _BikeRecordsScreenState extends State<BikeRecordsScreen> {
  final searchController = TextEditingController();

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
            'Bicycle Failures Records',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.fromLTRB(180, 16, 30, 16),
                child: TextField(
                  controller: searchController,
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
              //RecordsCard(),
              RecordsStream(),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordsStream extends StatelessWidget {
  const RecordsStream({Key? key}) : super(key: key);

  // var caller;
  @override
  Widget build(BuildContext context) {
    // print('widget build entrance');
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sos_call').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final records = snapshot.data?.docs;
          List<RecordsCard> recordCards = [];
          //isDone = true;
          int counter = 0;
          for (var record in records!) {
            // print('for loop entrance');
            final recordedDetails = record.get('sos_details');
            final recordedUser = record.get('caller_id');
            DateTime recordedDate = record.get('created_at').toDate();
            final recordedLocation = record.get('city');
            // final recordedLatitude = record.get('coordinates').latitude;
            // final recordedLongitude = record.get('coordinates').longitude;

            counter++;

            String time = DateFormat('hh:mm a').format(recordedDate);
            String date = DateFormat('MMMM dd, yyyy').format(recordedDate);

            final recordCard = RecordsCard(
              details: recordedDetails,
              caller: recordedUser,
              date: date,
              location: recordedLocation,
              time: time,
            );

            recordCards.add(recordCard);
          }
          print('Snapshot Size: ${snapshot.data?.docs.length}');
          return Expanded(
            child: ListView(
              children: recordCards,
            ),
          );
        });
  }
}

class RecordsCard extends StatefulWidget {
  const RecordsCard({
    Key? key,
    required this.details,
    required this.caller,
    required this.date,
    required this.location,
    required this.time,
  }) : super(key: key);

  final String details;
  final String caller;
  final String date;
  final String location;
  final String time;

  @override
  State<RecordsCard> createState() => _RecordsCardState();
}

class _RecordsCardState extends State<RecordsCard> {
  String? callerName;

  @override
  void initState() {
    // TODO: implement initState
    assigning();
    super.initState();
  }

  void assigning() async {
    print('assigning function');
    final caller = await readUser(widget.caller);
    print('after await function');
    setState(() {
      callerName = caller;
    });
    print('done assigning');
  }

  @override
  Widget build(BuildContext context) {
    print('widget builder');

    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFFFD4BC)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 70,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFED8F5B)),
                  child: const Center(
                    child: Text(
                      '01',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    const Text(
                      'Bicycle Failure Details:',
                      style: TextStyle(
                          fontFamily: 'OpenSansCondensed',
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Color(0xFF581D00)),
                    ),
                    Text(
                      widget.details,
                      style: (const TextStyle(
                          fontFamily: 'OpenSansCondensed',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Color(0xFF581D00))),
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
            const Align(
                alignment: Alignment.center,
                child: Text(
                  'SOS details:',
                  style: TextStyle(
                      fontFamily: 'OpenSansCondensed',
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                )),
            Row(
              children: [
                const Text(
                  'Caller: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  callerName.toString(),
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  'Responder: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  'Responder\'s Name',
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Date: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  widget.date,
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Time: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  widget.time,
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Location: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  widget.location,
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> readUser(String userID) async {
  ///Get Single Document by ID
  final docUser =
      FirebaseFirestore.instance.collection('user_profile').doc(userID);
  final snapshot = await docUser.get(); // get 1 document snapshot
  if (snapshot.exists) {
    //return User.fromJson(snapshot.data()!);
    return snapshot.get('first_name') + ' ' + snapshot.get('last_name');
  } else {
    return 'No User';
  }
  //
}
