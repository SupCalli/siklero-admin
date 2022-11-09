import 'package:flutter/material.dart';

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
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
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
              RecordsCard(),
              RecordsCard(),
              RecordsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordsCard extends StatelessWidget {
  const RecordsCard({
    Key? key,
  }) : super(key: key);

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
                  children: const [
                    Text(
                      'Bicycle Failure Details:',
                      style: TextStyle(
                          fontFamily: 'OpenSansCondensed',
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Color(0xFF581D00)),
                    ),
                    Text(
                      'Insert Bicyle Failure',
                      style: (TextStyle(
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
              children: const [
                Text(
                  'Caller: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  'Caller\'s Name',
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
              children: const [
                Text(
                  'Date: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  'Insert Date',
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  'Time: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  'Insert Time',
                  style: kUserDetailsTextStyle,
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  'Location: ',
                  style: kUserLabelTextStyle,
                ),
                Text(
                  'Insert Location',
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
