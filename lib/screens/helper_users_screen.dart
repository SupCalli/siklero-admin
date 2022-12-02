import 'package:flutter/material.dart';

final searchController = TextEditingController();

class ManageHelpers extends StatelessWidget {
  const ManageHelpers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Manage Helper Users',
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
                  //onChanged: searchUser,
                ),
              ),
              HelpersCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpersCard extends StatelessWidget {
  const HelpersCard({
    Key? key,
  }) : super(key: key);

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
                          child: const Center(
                            child: Text(
                              '01',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          //color: Color(0xFFED8F5B),
                        ),
                        Container(
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
                      ],
                    ),
                    const Text(
                      'User\'s First Name',
                      style: TextStyle(
                        fontFamily: 'OpenSansCondensed',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                    const Text(
                      'User\'s Last Name',
                      style: TextStyle(
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
            const Text(
              'Email',
              style: TextStyle(
                  fontFamily: 'OpenSansCondensed',
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
            const Text('Contact Number',
                style: TextStyle(
                    fontFamily: 'OpenSansCondensed',
                    fontWeight: FontWeight.w300,
                    fontSize: 16)),
            const Text('Address',
                style: TextStyle(
                    fontFamily: 'OpenSansCondensed',
                    fontWeight: FontWeight.w300,
                    fontSize: 16)),
          ],
        ));
  }
}
