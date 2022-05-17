import 'package:flutter/material.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Entities/User.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:project/Views/User/home.dart';
import 'package:provider/provider.dart';

import '../../../Entities/My_Order.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:project/Views/User/Cart_Widgets/Counter.dart';

import 'AnimatedButton.dart';

class MyOrderWidget extends StatefulWidget {
  MyOrder myOrder;

  MyOrderWidget({Key? key, required this.myOrder}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrderWidget> {
  @override
  Widget build(BuildContext context) {
    List<OrderItem> orders = context.read<ScanProvider>().getOrderList();

    return Column(
      children: [
        Container(
          height: orders.length > 1 ? 330 : 280,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  decoration: const BoxDecoration(
                    color: Color(0xF0ADD9C9),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
              ),
              Picture(
                  radius: 40,
                  border: 4,
                  image: context.read<UserProvider>().getImage()),
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You',
                      style: TextStyle(
                          color: Color(0xFF154038),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    widget.myOrder.isPlaced
                        ? const Text(
                            'have placed your order..',
                            style: TextStyle(
                                color: Color(0xFF154038),
                                fontSize: 14,
                                fontStyle: FontStyle.italic),
                          )
                        : const Text(
                            'are deciding..',
                            style: TextStyle(
                                color: Color(0xFF154038),
                                fontSize: 14,
                                fontStyle: FontStyle.italic),
                          ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: orders.length > 1 ? 20 : 70),
                  child: SizedBox(
                    width: 300,
                    height: 150,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: orders.length,
                      itemBuilder: (context, index) => Container(
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Color(0x905ABFA3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: const Offset(4, 4),
                            )
                          ],
                        ),
                        child: LimitedBox(
                          //to solve problem of row in list view
                          maxHeight: 100.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 16),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          orders[index].image,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orders[index].name,
                                        style: const TextStyle(
                                            color: Color(0xFF154038),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$" + orders[index].price.toString(),
                                        style: const TextStyle(
                                            color: Color(0xFF154038),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Counter(
                                    canEdit:
                                        widget.myOrder.isPlaced ? false : true,
                                    onChangeValue: (value) {
                                      print(value);
                                      if (value != 0) {
                                        orders[index].quantity = value;
                                      } else {
                                        orders.remove(orders[index]);
                                      }
                                      context
                                          .read<ScanProvider>()
                                          .addToOrderFirebase(
                                              email: context
                                                  .read<UserProvider>()
                                                  .getEmail(),
                                              qr_id: context
                                                  .read<ScanProvider>()
                                                  .getQRID(),
                                              orders: orders);
                                      setState(() {});
                                    },
                                    min: 0,
                                    max: 5,
                                    value: orders[index].quantity,
                                    increments: 1)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, bottom: 55),
                    child: Text(
                      'Total: ' +
                          '  ' +
                          '\$' +
                          context
                              .watch<ScanProvider>()
                              .Total(
                                  context.read<ScanProvider>().getOrderList())
                              .toString(),
                      style: const TextStyle(
                        color: Color(0xFF154038),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: widget.myOrder.isPlaced
                      ? null
                      : SizedBox(
                          height: 42,
                          child: AnimatedButton(
                            order_length: orders.length,
                            isPlaced: (bool) {
                              if (bool) {
                                widget.myOrder.MarkPlaced();
                                setState(() {});
                              }
                            },
                          )),
                  // : SizedBox(
                  //     height: 42,
                  //     child: FittedBox(
                  //       child: FloatingActionButton.extended(
                  //           onPressed: () {
                  //             if (orders.isNotEmpty) {
                  //               context
                  //                   .read<ScanProvider>()
                  //                   .updateOrderStatusInFirebase(
                  //                       email: context
                  //                           .read<UserProvider>()
                  //                           .getEmail(),
                  //                       qr_id: context
                  //                           .read<ScanProvider>()
                  //                           .getQRID(),
                  //                       status: true);
                  //               setState(() {});
                  //               widget.myOrder.MarkPlaced();
                  //               context
                  //                   .read<OrdersProvider>()
                  //                   .setMyOrderStatus(true);
                  //             }
                  //           },
                  //           backgroundColor: Color(0xFF5ABFA3),
                  //           label: const Text('Place Order')),
                  //     ),
                  //   ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 42,
            child: FittedBox(
              child: FloatingActionButton.extended(
                  onPressed: () async {
                    context.read<ScanProvider>().exitCart(
                        email: context.read<UserProvider>().getEmail(),
                        qr_id: context.read<ScanProvider>().getQRID());
                    context.read<UserProvider>().setQR(false);
                    var exit = await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Exiting Cart",
                              style: TextStyle(
                                  color: Color(0xFF5ABFA3),
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              "Are you sure you want to exit",
                              style: TextStyle(fontSize: 13),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Color(0xFF5ABFA3),
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: Color(0xFF5ABFA3),
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              )
                            ],
                          );
                        });

                    if (exit) {
                      Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                              (Route<dynamic> route) => false)
                          .then((_) => setState(() {}));
                    }
                  },
                  backgroundColor: Color.fromARGB(255, 75, 156, 143),
                  label: const Text('Exit Cart')),
            ),
          ),
        )
      ],
    );
  }
}
