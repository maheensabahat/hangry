import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List orders = [
    'Order',
    'Order',
    'Order',
    'Order',
    'Order',
    'Order',
    'Order',
    'Order'
  ];
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'My Orders',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Snap(
        controller: controller.appBar,
        child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          //shrinkWrap: true,
          itemExtent: 100,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xffadd9c9)),
                height: 100,
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: ListTile(
                    trailing: const Text('Order Date'),
                    leading: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 100,
                        width: 70,
                        color: const Color(0xff5abfa3),
                      ),
                    ),
                    tileColor: const Color(0xffadd9c9),
                    title: Text(
                      orders[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: const Text('Order ID 12345678',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
