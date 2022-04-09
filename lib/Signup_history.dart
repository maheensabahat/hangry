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
                  expandedHeight: 200,
                  backgroundColor: Color(0xFF5ABFA3),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        Flexible(
                            child: Text(
                          "Welcome Admin",
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Pending Signups',
                      ),
                      Tab(
                        text: 'Approved Signups',
                      ),
                      Tab(
                        text: 'Rejected Signups',
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

class Signups{
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
          decoration: const BoxDecoration(color: Color(0xffadd9c9)),
          height: 100,
          child: Align(
            alignment: const Alignment(0, 0),
            child: InkWell(
              child: ListTile(
                title: Text(x[index].name),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Signup_View()));
                },
                //if conditions here to see from which tab bar is it clicked from
                //if it's not clicked from pending then it wouldn't show approve reject buttons in the next phase
                trailing: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 100,
                    width: 70,
                    color: const Color(0xff5abfa3),
                  ),
                ),
                tileColor: const Color(0xffadd9c9),
              ),
            ),
          ),
        ),
      );
    },
  );
}
