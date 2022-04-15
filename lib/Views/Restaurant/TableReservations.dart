import 'package:flutter/material.dart';
import 'package:project/Views/Restaurant/ReservationRequests.dart';
import 'ReservationRequests.dart';

class TableReservations extends StatefulWidget {

  const TableReservations({Key? key}) : super(key: key);

  @override
  _TableReservationsState createState() => _TableReservationsState();
}

class _TableReservationsState extends State<TableReservations>
    with SingleTickerProviderStateMixin {
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
  late final _tabController = TabController(length: 3, vsync: this);

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          foregroundColor: Colors.black,
          backgroundColor: Color(0xA05ABFA3),
          title: Column(
            children: [
              Text(
                "Restaurant's name",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Table reservation history",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
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
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: list(Pending_tables, 'Pending'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Approved_tables, 'Approved'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Rejected_reservation, 'Rejected'),
              ),
            ),
          ],
        ),
      );
}

class tables {
  final String name;
  final String time;

  tables({required this.name, required this.time});
}

ListView list(List x, String type) {
  return ListView.builder(
    itemExtent: 100,
    itemCount: x.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0x505ABFA3),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 100,
          child: Align(
            alignment: const Alignment(0, 0),
            child: InkWell(
              child: ListTile(
                title: Text(
                  x[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReservationRequests(type: type)));
                },
                //if conditions here to see from which tab bar is it clicked from
                //if it's not clicked from pending then it wouldn't show approve reject buttons in the next phase
                subtitle: Text(x[index].time,
                    style: TextStyle(fontWeight: FontWeight.w500)),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
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
