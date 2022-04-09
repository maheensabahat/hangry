import 'package:flutter/material.dart';
import 'package:project/RestaurantOrder.dart';
import 'package:project/Views/User/Cart.dart';

class Order_history extends StatefulWidget {
  const Order_history({Key? key}) : super(key: key);

  @override
  _Order_historyState createState() => _Order_historyState();
}

class _Order_historyState extends State<Order_history> {
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
                          "Orders history",
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'Pending Orders',
                      ),
                      Tab(
                        text: 'Approved Orders',
                      ),
                      Tab(
                        text: 'Rejected Orders',
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
                    child: list(Pending_Orders),
                  ),
                ),
                MaterialApp(
                  home: Center(
                    child: list(Approved_Orders),
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Container(
          decoration: const BoxDecoration(color: Color(0xffadd9c9)),
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
                title: Text(x[index].name),
                // leading: Icon(Icons.restaurant),
                subtitle: Text(x[index].time),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
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
