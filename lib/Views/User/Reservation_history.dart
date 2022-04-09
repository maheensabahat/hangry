import 'package:flutter/material.dart';

class Reservation_history extends StatefulWidget {
  const Reservation_history({Key? key}) : super(key: key);

  @override
  _Reservation_historyState createState() => _Reservation_historyState();
}

class _Reservation_historyState extends State<Reservation_history> {
  @override
  List<Reservations> Approved_reservations = [
    Reservations(name: "Restaurant name 4", time: "18:00", status: "Today"),
    Reservations(name: "Restaurant name 2", time: "17:00", status: "Today"),
    Reservations(name: "Restaurant name 6", time: "19:00", status: "Today"),
    Reservations(name: "Restaurant name 1", time: "11:00", status: "Today"),
    Reservations(name: "Restaurant name 8", time: "1:00", status: "Upcoming"),
    Reservations(name: "Restaurant name 17", time: "12:00", status: "Upcoming"),
    Reservations(name: "Restaurant name 23", time: "19:00", status: "Upcoming"),
    Reservations(name: "Restaurant name 29", time: "18:00", status: "Upcoming"),
  ];

  List<Reservations> Unapproved_reservations = [
    Reservations(name: "Restaurant name 3", time: "02:00", status: "Pending"),
    Reservations(name: "Restaurant name 7", time: "12:30", status: "Pending"),
    Reservations(name: "Restaurant name 9", time: "01:30", status: "Pending"),
    Reservations(name: "Restaurant name 11", time: "01:45", status: "Pending"),
    Reservations(name: "Restaurant name 15", time: "16:45", status: "Pending"),
    Reservations(
        name: "Restaurant name 20", time: "16:00", status: "Cancelled"),
    Reservations(
        name: "Restaurant name 25", time: "17:30", status: "Cancelled"),
    Reservations(name: "Restaurant name 19", time: "17:30", status: "Cancelled")
  ];

  Widget build(BuildContext context) => Scaffold(
        body: DefaultTabController(
          length: 2,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        Flexible(
                            child: Text(
                          "Restaurant name",
                          textAlign: TextAlign.center,
                        )),
                        Flexible(
                            child: Text(
                          "Reservation requests status",
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.black.withOpacity(0.75)),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Approved',
                      ),
                      Tab(
                        text: 'Unapproved',
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
                    child: list(Approved_reservations),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Unapproved_reservations),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class Reservations {
  final String name;
  final String time;
  final String status;

  Reservations({required this.name, required this.time, required this.status});
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
                // leading: Icon(Icons.restaurant),
                subtitle: Text(x[index].time + "   " + x[index].status),
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
