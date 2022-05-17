import 'package:flutter/material.dart';
import 'package:project/Entities/User_order.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import 'OrderSummaryUser.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    context
        .read<OrdersProvider>()
        .getOrdersFromFirebase(email: context.read<UserProvider>().getEmail());
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'My Orders',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),

          //Orders list view
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: ListView.builder(
                itemExtent: 100,
                itemCount:
                    context.read<OrdersProvider>().getUserOrders().length,
                itemBuilder: (context, index) {
                  List<UserOrders> order =
                      context.read<OrdersProvider>().getUserOrders();
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 25, left: 5, right: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0x905ABFA3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      //List Tile - Each Order
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderSummaryUser(
                                    name:
                                        context.read<UserProvider>().getName(),
                                    productDetails:
                                        order[index].product_details!)),
                          );
                        },
                        child: ListTile(
                          //Order date
                          trailing: Text(
                            order[index].date.substring(0, 10),
                            style: TextStyle(fontSize: 11),
                          ),

                          //Image

                          //Order Title
                          title: Text(
                            context
                                .read<RestaurantProvider>()
                                .getRestaurantName(order[index].restaurant_id),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          //Order No.
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text("Order ID: " + order[index].id,
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
