import 'package:flutter/material.dart';
import 'package:project/Views/Restaurant/ReservationRequests.dart';

class UserTableReservations extends StatefulWidget {
  const UserTableReservations({Key? key}) : super(key: key);

  @override
  _UserTableReservationsState createState() => _UserTableReservationsState();
}

class _UserTableReservationsState extends State<UserTableReservations>
    with SingleTickerProviderStateMixin {
  @override
  List<Request> Pending_Request = [
    Request(name: "Restaurant 1", id: "req1"),
    Request(name: "Restaurant 2", id: "req2"),
    Request(name: "Restaurant 3", id: "req3"),
    Request(name: "Restaurant 4", id: "req4"),
    Request(name: "Restaurant 5", id: "req5"),
    Request(name: "Restaurant 6", id: "req6"),
  ];

  List<Request> Approved_Request = [
    Request(name: "Restaurant 7", id: "req7"),
    Request(name: "Restaurant 8", id: "req8"),
    Request(name: "Restaurant 9", id: "req9"),
    Request(name: "Restaurant 10", id: "req10"),
  ];

  late final _tabController = TabController(length: 2, vsync: this);

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          foregroundColor: Colors.black,
          backgroundColor: Color(0xA05ABFA3),
          title: Column(
            children: [
              Text(
                "Reservation History",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Reservation requests status",
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
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: list(Pending_Request, 'Pending'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Approved_Request, 'Approved'),
              ),
            ),
          ],
        ),
      );
}

class Request {
  final String name;
  final String id;

  Request({required this.name, required this.id});
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
                subtitle: Text(x[index].id,
                    style: TextStyle(fontWeight: FontWeight.w500)),
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
