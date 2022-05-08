import 'package:flutter/material.dart';
import 'package:project/Views/Restaurant/RestaurantOrder.dart';

import '../../Entities/Products.dart';

class Order_history extends StatefulWidget {
  const Order_history({Key? key}) : super(key: key);

  @override
  _Order_historyState createState() => _Order_historyState();
}

class _Order_historyState extends State<Order_history>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  List<Orders> Pending_Orders = [
    Orders(name: "Order 4", time: "18:00"),
    Orders(name: "Order 2", time: "17:00"),
    Orders(name: "Order 6", time: "19:00"),
    Orders(name: "Order 1", time: "11:00"),
    Orders(name: "Order 8", time: "1:00"),
    Orders(name: "Order 17", time: "12:00"),
    Orders(name: "Order 23", time: "19:00"),
    Orders(name: "Order 29", time: "18:00"),
  ];

  List<Orders> Approved_Orders = [
    Orders(name: "Order 3", time: "02:00"),
    Orders(name: "Order 7", time: "12:30"),
    Orders(name: "Order 9", time: "01:30"),
    Orders(name: "Order 11", time: "01:45"),
    Orders(name: "Order 15", time: "16:45"),
    Orders(name: "Order 20", time: "16:00"),
    Orders(name: "Order 25", time: "17:30"),
    Orders(name: "Order 19", time: "17:30")
  ];

  List<Orders> Rejected_reservation = [
    Orders(name: "Order 3", time: "17:30"),
    Orders(name: "Order 13", time: "17:30"),
    Orders(name: "Order 18", time: "15:30"),
    Orders(name: "Order 30", time: "13:30"),
    Orders(name: "Order 16", time: "5:00"),
  ];

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                "Restaurant's name",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Order history",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 24),
            controller: _tabController,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xF05ABFA3),
                Color(0xA05ABFA3),
                Color(0xA05ABFA3),
                Color(0xF05ABFA3),
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
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
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Pending_Orders),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Approved_Orders),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Container(
                child: list(Rejected_reservation),
              ),
            ),
          ],
        ),
      );
}

class Orders {
  final String name;
  final String time;

  Orders({required this.name, required this.time});
}

ListView list(List x) {
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RestaurantOrder()),
                );
              },
              child: ListTile(
                  title: Text(
                    x[index].name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  // leading: Icon(Icons.restaurant),
                  subtitle: Text(x[index].time),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.fastfood,
                      color: Colors.black,
                      size: 30,
                    ),
                  )),
            ),
          ),
        ),
      );
    },
  );
}
