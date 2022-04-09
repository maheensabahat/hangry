import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup_View.dart';
import 'Signup_View.dart';

class Signup_history extends StatefulWidget {
  const Signup_history({Key? key}) : super(key: key);

  @override
  _Signup_historyState createState() => _Signup_historyState();
}

class _Signup_historyState extends State<Signup_history> {
  @override
  List<Signups> Pending_signups = [
    Signups(name: "O Donuts"),
    Signups(name: "Moos n Clucks"),
    Signups(name: "Fibbi Cafe"),
    Signups(name: "KFC"),
    Signups(name: "Cafe Praha"),
    Signups(name: "Cafe Picante"),
    Signups(name: "CFU"),
    Signups(name: "Vegas"),
  ];

  List<Signups> Approved_signups = [
    Signups(name: "Mcdonalds"),
    Signups(name: "Cafe two or more"),
    Signups(name: "Ziist"),
    Signups(name: "Big C restaurant"),
    Signups(name: "Cafe Aylanto"),
    Signups(name: "Burger o clock"),
    Signups(name: "Kababjees Express"),
    Signups(name: "De Valley"),
    Signups(name: "Xander\'s"),
    Signups(name: "Sizzlers"),
    Signups(name: "Del Frio"),
  ];

  List<Signups> Signup_history = [
    Signups(name: "Boxd"),
    Signups(name: "Big Bash"),
    Signups(name: "Burger Lab"),
    Signups(name: "2 guys bistro"),
    Signups(name: "Thirsty"),
  ];

  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 180,
                  backgroundColor: Color(0xFF5ABFA3),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 80, left: 13),
                          child: Text(
                            "Welcome, Admin!",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, left: 13),
                          child: Text(
                            "Restaurant Sign Ups",
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Pending',
                      ),
                      Tab(
                        text: 'Approved',
                      ),
                      Tab(
                        text: 'Rejected',
                      ),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                MaterialApp(
                  home: Center(
                    child: list(Pending_signups),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Approved_signups),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Signup_history),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class Signups {
  final String name;

  Signups({required this.name});
}

ListView list(List x) {
  return ListView.builder(
    itemExtent: 100,
    itemCount: x.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0x905ABFA3),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 100,
          child: Align(
            alignment: const Alignment(0, 0),
            child: InkWell(
              child: ListTile(
                title: Text(
                  x[index].name,
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Signup_View()));
                },
                //if conditions here to see from which tab bar is it clicked from
                //if it's not clicked from pending then it wouldn't show approve reject buttons in the next phase
                trailing: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.black87,
                  ),
                  onPressed: () {},
                ),
                leading: Container(
                  height: 100,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/restaurant.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
