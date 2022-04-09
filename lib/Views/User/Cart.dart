import 'package:flutter/material.dart';
import 'package:project/Views/User/Counter.dart';
import 'package:project/Views/User/Widgets/Header.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';

import '../../Entities/User.dart';
import '../../Entities/cart.dart';

class Cart extends StatefulWidget {
  List<Order> friends = [
    Order(name: 'Veronica', isDeciding: true),
    Order(name: 'James', isDeciding: false),
  ];
  User user;

  Cart({Key? key, required this.user}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Header(
              title: 'Cart',
              bottom: 20,
            ),
          ),
          if (widget.user.qr) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MyOrder(
                myOrder: widget.user.currentCart,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 36, bottom: 12),
              child: Text(
                'Friends',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 42, right: 42, bottom: 26),
              child: Container(
                height: 150,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.friends.length,
                  itemBuilder: (context, index) => widget.friends[index],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 36),
              child: Summary(),
            ),
          ] else ...[
            Center(
                child: Text(
              'Empty Cart',
            ))
          ],
        ],
      ),
    );
  }
}

class MyOrder extends StatefulWidget {
  cart myOrder;
  bool placed = false;

  MyOrder({Key? key, required this.myOrder}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return !widget.placed
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
                            widget.myOrder.calculateTotal().toString(),
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
                              widget.placed = true;
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
        : Order(name: 'You', isDeciding: false);
  }
}

class Order extends StatelessWidget {
  String name;
  bool isDeciding;

  Order({Key? key, required this.name, required this.isDeciding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xF0ADD9C9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomRight: Radius.circular(30)),
              ),
            ),
          ),
          Picture(
            radius: 35,
            border: 3,
            image: 'assets/profile.png',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: Color(0xFF154038),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                if (isDeciding) ...[
                  Text(
                    'is deciding..',
                    style: TextStyle(
                        color: Color(0xFF154038),
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                ] else ...[
                  Text(
                    'has placed order',
                    style: TextStyle(
                        color: Color(0xFF154038),
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ],
            ),
          ),
          if (!isDeciding) ...[
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, bottom: 35),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 20),
                  child: Text(
                    'Total: ' + '  ' + '\$120',
                    style: TextStyle(
                      color: Color(0xFF154038),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Grand Total:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  '\$20',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Tax:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  '\$20',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Net Total:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  '\$20',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
