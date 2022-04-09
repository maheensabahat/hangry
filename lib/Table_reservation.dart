import 'package:flutter/material.dart';

class Table_reservation extends StatefulWidget {
  const Table_reservation({Key? key}) : super(key: key);

  @override
  _Table_reservationState createState() => _Table_reservationState();
}

class _Table_reservationState extends State<Table_reservation> {
  @override
  List<tables> Pending_tables = [
    tables(name: "Table 4", time: "18:00"),
    tables(name: "Table 2", time: "17:00"),
    tables(name: "Table 6", time: "19:00"),
    tables(name: "Table 1", time: "11:00"),
    tables(name: "Table 8", time: "1:00"),
    tables(name: "Table 17", time: "12:00"),
    tables(name: "Table 23", time: "19:00"),
    tables(name: "Table 29", time: "18:00"),
  ];

  List<tables> Approved_tables = [
    tables(name: "Table 3", time: "02:00"),
    tables(name: "Table 7", time: "12:30"),
    tables(name: "Table 9", time: "01:30"),
    tables(name: "Table 11", time: "01:45"),
    tables(name: "Table 15", time: "16:45"),
    tables(name: "Table 20", time: "16:00"),
    tables(name: "Table 25", time: "17:30"),
    tables(name: "Table 19", time: "17:30")
  ];

  List<tables> Rejected_reservation = [
    tables(name: "Table 3", time: "17:30"),
    tables(name: "Table 13", time: "17:30"),
    tables(name: "Table 18", time: "15:30"),
    tables(name: "Table 30", time: "13:30"),
    tables(name: "Table 16", time: "5:00"),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  backgroundColor: const Color(0xFF5ABFA3),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        const Flexible(
                          child: Align(
                            child: Text(
                              "Restaurant name",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Flexible(
                          child: Text(
                            "Table reservation history",
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        text: 'Pending tables',
                      ),
                      Tab(
                        text: 'Approved tables',
                      ),
                      Tab(
                        text: 'Rejected tables',
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                MaterialApp(
                  home: Center(
                    child: list(Pending_tables),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Approved_tables),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Rejected_reservation),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class tables {
  final String name;
  final String time;

  tables({required this.name, required this.time});
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
            child: ListTile(
              title: Text(x[index].name),
              // leading: Icon(Icons.restaurant),
              subtitle: Text(x[index].time),

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
      );
    },
  );
}
