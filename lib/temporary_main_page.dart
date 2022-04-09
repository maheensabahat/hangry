import 'package:flutter/material.dart';
import 'package:project/main.dart';

import 'RestaurantHome.dart';
import 'Views/User/home.dart';

class TempMain extends StatefulWidget {
  const TempMain({Key? key}) : super(key: key);

  @override
  State<TempMain> createState() => _TempMainState();
}

class _TempMainState extends State<TempMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Text(
              'Log in as',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
            child: SizedBox(
              height: 40,
              width: 140,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFF154038),
                    primary: Color(0xFF5ABFA3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                          title: '',
                        ),
                      ),
                    );
                  },
                  child: Text('Customer')),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: SizedBox(
              height: 40,
              width: 140,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFF154038),
                    primary: Color(0xFF5ABFA3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RestaurantHome()),
                    );
                  },
                  child: Text('Restaurant')),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: SizedBox(
              height: 40,
              width: 140,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFF154038),
                    primary: Color(0xFF5ABFA3),
                  ),
                  onPressed: null,
                  // (){
                  //    Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const ()),
                  //         );
                  // },
                  child: Text('Admin')),
            ),
          ),
        ],
      )),
    );
  }
}
