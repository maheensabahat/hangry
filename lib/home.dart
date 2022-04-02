import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 24),
              child: Text('Hi, Jimmy!',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5ABFA3))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'What do you\nwant to eat today?',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color(0xFF5ABFA3),
                  radius: 42,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TextField(
                controller: search,
                style: const TextStyle(color: Color(0xFF5ABFA3)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 1.0, color: Color(0xFF5ABFA3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFF5ABFA3))),
                    hintText: 'Search here',
                    hintStyle: const TextStyle(
                      color: Color(0xFFADD9C9),
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: Color(0x30ADD9C9),
                    suffixIcon: InkWell(
                        child: Icon(
                      Icons.search,
                      color: Color(0xFF5ABFA3),
                    ))),
                cursorColor: Color(0xFF5ABFA3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
