import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siklero_admin/constants.dart';
import 'package:siklero_admin/screens/csv_screen.dart';

List<RecordsCard> searchCards = [];
bool isDone = false;

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
                margin: EdgeInsets.fromLTRB(100, 16, 30, 16),
                child: Row(
                  children: [
                    IconButton(
                        tooltip: 'Generate CSV file',
                        color: Colors.green,
                        onPressed: () {
                          print('sheesh');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CsvPage(records: userCards),
                              ));
                        },
                        icon: Icon(Icons.print)),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: TextField(
                        controller: searchController,
                        textAlignVertical: TextAlignVertical.bottom,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFFE45F1E)),
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
                        onChanged: searchUser,
                      ),
                    ),
                  ],
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

  void searchUser(String query) {
    final suggestions = userCards.where((record) {
      final callerName = record.caller.toLowerCase();
      final input = query.toLowerCase();
      return callerName.contains(input);
    }).toList();
    setState(() {
      searchCards = suggestions;
    });
  }
}

class RecordsStream extends StatefulWidget {
  const RecordsStream({Key? key}) : super(key: key);

  @override
  State<RecordsStream> createState() => _RecordsStreamState();
}

class _RecordsStreamState extends State<RecordsStream> {
  late Stream<List<RecordsCard>> recordsStream;
  var caller;
  bool isDone = false;

  Future<RecordsCard> generateRecords(DocumentSnapshot snapshot) async {
    print('generate Records');

    final callerName = await readUser(snapshot.get('caller_id'));
    final responderID = snapshot.get('respondant_id');
    String? responderName;
    if (responderID != null) {
      responderName = await readUser(responderID);
    } else {
      responderName = '    ';
    }

    String time =
        DateFormat('hh:mm a').format(snapshot.get('created_at').toDate());
    String date =
        DateFormat('MMMM dd, yyyy').format(snapshot.get('created_at').toDate());

    print(callerName! + time + date + responderName!);
    return RecordsCard(
      details: snapshot.get('sos_details'),
      caller: callerName.toString(),
      date: date,
      location: snapshot.get('city'),
      time: time,
      responder: responderName.toString(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    recordsStream = FirebaseFirestore.instance
        .collection('sos_call')
        .orderBy('created_at', descending: false)
        .snapshots()
        .asyncMap((records) => Future.wait(
            [for (var record in records.docs) generateRecords(record)]));
    // firestoreStream =
    //     FirebaseFirestore.instance.collection('sos_call').snapshots();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RecordsCard>>(
        stream: recordsStream,
        builder: (context, snapshot) {
          //print('This is a record', {$records});
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          } else {
            final records = snapshot.data;
            if (!isDone || snapshot.data?.length != userCards.length) {
              userCards.clear();
              userCards = records!;
              searchCards = userCards;
              isDone = true;
            }
            // print('Snapshot Size: ${snapshot.data?.docs.length}');
            return Expanded(
              child: ListView.builder(
                itemCount: searchCards.length,
                itemBuilder: (context, index) {
                  final searchCard = searchCards[index];

                  return RecordsCard(
                    details: searchCard.details,
                    caller: searchCard.caller,
                    date: searchCard.date,
                    location: searchCard.location,
                    time: searchCard.time,
                    responder: searchCard.responder,
                  );
                },
              ),
            );
          }
        });
  }

  Future<String?> readUser(String userID) async {
    ///Get Single Document by ID
    final docUser =
        FirebaseFirestore.instance.collection('user_profile').doc(userID);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return snapshot.get('first_name') + ' ' + snapshot.get('last_name');
    } else {
      return 'No User';
    }
    //
  }
}

class RecordsCard extends StatelessWidget {
  const RecordsCard({
    Key? key,
    required this.details,
    required this.caller,
    required this.date,
    required this.location,
    required this.time,
    required this.responder,
  }) : super(key: key);

  final String details;
  final String caller;
  final String date;
  final String location;
  final String time;
  final String responder;

  @override
  Widget build(BuildContext context) {
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
                      details,
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
                  caller,
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Responder: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  responder,
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
                  date,
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
                  time,
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
                  location,
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

List<RecordsCard> userCards = [];
