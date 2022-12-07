import 'package:flutter/material.dart';
import 'package:siklero_admin/screens/bikefailures_records_screen.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class CsvPage extends StatefulWidget {
  const CsvPage({Key? key, required this.records}) : super(key: key);
  final List<RecordsCard> records;

  @override
  State<CsvPage> createState() => _CsvPageState();
}

class _CsvPageState extends State<CsvPage> {
  List<String> title = [];
  List<String> spaces = [];
  List<String> header = []; //Header list variable
  List<List<String>> listOfLists = [];
  List<String> dataRecord = [];
  @override
  void initState() {
    // TODO: implement initState

    header.clear();
    dataRecord.clear();
    listOfLists.clear();
    title.add(' ');
    title.add(' ');
    title.add('Bicycle Failure Records');
    spaces.add('');
    header.add('Caller');
    header.add('Responder');
    header.add('Date');
    header.add('Time');
    header.add('Location');

    listOfLists.add(title);
    listOfLists.add(spaces);
    listOfLists.add(header);

    super.initState();
  }

  Widget HeaderRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 17, top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            header[0],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            header[1],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            header[2],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            header[3],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            header[4],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderRow(),
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: widget.records.length,
                  itemBuilder: (context, index) {
                    final record = widget.records[index];

                    dataRecord.add(record.caller);
                    dataRecord.add(record.responder);
                    dataRecord.add(record.date);
                    dataRecord.add(record.time);
                    dataRecord.add(record.location);
                    listOfLists.add(dataRecord);
                    dataRecord = [];

                    return Records(
                        caller: record.caller,
                        responder: record.responder,
                        date: record.date,
                        time: record.time,
                        location: record.location);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 130,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            child: TextButton(
              child: const Text(
                'Export CV',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                exportCSV.myCSV(header, listOfLists);
              },
            ),
          )),
    );
  }
}

class Records extends StatelessWidget {
  const Records(
      {Key? key,
      required this.caller,
      required this.responder,
      required this.date,
      required this.time,
      required this.location})
      : super(key: key);

  final String caller;
  final String responder;
  final String date;
  final String time;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            caller,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            responder,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            location,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
