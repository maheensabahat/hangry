import 'package:flutter/material.dart';

import '../../../Entities/My_Order.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:project/Views/User/Cart_Widgets/Counter.dart';

import 'Order.dart';

class MyOrderWidget extends StatefulWidget {
  MyOrder myOrder;

  MyOrderWidget({Key? key, required this.myOrder}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return !widget.myOrder.isPlaced
        ? Container(
            height: 330,
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
                Picture(radius: 40, border: 4, image: 'assets/profile.png'),
                Padding(
                  padding: const EdgeInsets.only(left: 100, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You',
                        style: TextStyle(
                            color: Color(0xFF154038),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 300,
                      height: 150,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.myOrder.list.length,
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
                            //to solve proble of row in list view
                            maxHeight: 100.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/pasta.jpg',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.myOrder.list[index].name,
                                          style: TextStyle(
                                              color: Color(0xFF154038),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "\$" +
                                              widget.myOrder.list[index].price
                                                  .toString(),
                                          style: TextStyle(
                                              color: Color(0xFF154038),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Counter(
                                      min: 0,
                                      max: 5,
                                      value:
                                          widget.myOrder.list[index].quantity,
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
                      padding: const EdgeInsets.only(right: 24, bottom: 45),
                      child: Text(
                        'Total: ' +
                            '  ' +
                            '\$' +
                            widget.myOrder.Total().toString(),
                        style: TextStyle(
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
                    child: SizedBox(
                      height: 42,
                      child: FittedBox(
                        child: FloatingActionButton.extended(
                            onPressed: () {
                              widget.myOrder.MarkPlaced();
                              setState(() {});
                            },
                            backgroundColor: Color(0xFF5ABFA3),
                            label: Text('Place Order')),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Order(
            name: 'You',
            order: widget.myOrder,
          );
  }
}
