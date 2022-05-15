import 'package:flutter/material.dart';
import 'package:project/Providers/AdminProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/Restaurant/RestaurantOrder.dart';
import 'package:provider/provider.dart';
import '../../Providers/RestaurantProvider.dart';
import '../../Entities/Products.dart';
import '../../Providers/RestaurantProvider.dart';
import '../Admin/AdRestaurantsDisplay.dart';
import 'RestaurantHome.dart';
import 'Widgets/BackButton.dart';

class Order_history extends StatefulWidget {
  const Order_history({Key? key}) : super(key: key);

  @override
  _Order_historyState createState() => _Order_historyState();
}

class _Order_historyState extends State<Order_history>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  late List<Orders?> Pending_Orders = [];

  late List<Orders?> Approved_Orders = [];

  late List<Orders?> Rejected_orders = [];

  var restaurant_id;


  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Back(
            route: MaterialPageRoute(builder: (context) => RestaurantHome()),
          ),
          toolbarHeight: 150,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
          context.read<RestaurantProvider>().restaurant.name,
          textAlign: TextAlign.center,
          ),
          const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
          "Order history",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
          ),
          ),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            controller: _tabController,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xF05ABFA3),
                Color(0xA05ABFA3),
                Color(0xA05ABFA3),
                Color(0xF05ABFA3),
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: const [
              Tab(
                text: 'Pending'),
              Tab(
                text: 'Approved'),
              Tab(
                text: 'Rejected'),
            ],
          ),
        ),
        body: Consumer<RestaurantProvider>(builder: (context, provider, child) {
         return (provider.isLoaded)
              ? TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: Container(
                  child: list(Pending_Orders =
                  context.read<RestaurantProvider>().getRestOrders(
                      restaurant_id, "Pending") as List<Orders?>),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: Container(
                  child: list(Approved_Orders =
                  context.read<RestaurantProvider>().getRestOrders(
                      restaurant_id, "Approved") as List<Orders?>),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: Container(
                  child: list(Rejected_orders =
                  context.read<RestaurantProvider>().getRestOrders(
                      restaurant_id, "Approved") as List<Orders?>),
                ),
              ),
            ],
          )
              : Center(
          child: Container(
          child: const CircularProgressIndicator(
          color: Color(0xffadd9c9),
          ),
          height: 50,
          width: 50,
          ));

        })

      );
}

class Orders {
  final String name;
  final String time;

  Orders({required this.name, required this.time});
}

ListView? list(List x) {
  ListView.builder(
      itemExtent: 100,
      itemCount: x.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0x505ABFA3),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 100,
            child: Align(
              alignment: const Alignment(0, 0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantOrder()),);},
                child: ListTile(
                    title: Text(
                      x[index].tableNum,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // leading: Icon(Icons.restaurant),
                    subtitle: Text(x[index].user_id),
                    trailing:  IconButton(
                      icon: const Icon(Icons.chevron_right),
                      color: Colors.black,
                      onPressed: (){},
                    ),
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
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

