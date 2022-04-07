import 'package:flutter/material.dart';
import 'package:project/Views/User/Counter.dart';

class Cart extends StatefulWidget {
  bool isPlaced = false;
  List<Order> friends = [
    Order(name: 'Veronica', isDeciding: true),
    Order(name: 'James', isDeciding: false),
  ];

  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20),
              child: Text(
                'Cart',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: widget.isPlaced
                ? Order(name: 'You', isDeciding: false)
                : MyUnplacedOrder(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 36, bottom: 12),
            child: Text('Friends', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),),
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
          )
        ],
      ),
    );
  }
}

class MyUnplacedOrder extends StatefulWidget {
  const MyUnplacedOrder({Key? key}) : super(key: key);

  @override
  _MyUnplacedOrderState createState() => _MyUnplacedOrderState();
}

class _MyUnplacedOrderState extends State<MyUnplacedOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          CircleAvatar(
            backgroundColor: Color(0xFF5ABFA3),
            radius: 44,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
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
                  itemCount: 4,
                  itemBuilder: (context, index) => Container(
                    height: 70,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: Color(0x905ABFA3),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                        padding: const EdgeInsets.only(left: 10, right: 16),
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
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pizza',
                                    style: TextStyle(
                                        color: Color(0xFF154038),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$20",
                                    style: TextStyle(
                                        color: Color(0xFF154038),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Counter(min: 0, max: 5, value: 1, increments: 1)
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 42,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                      onPressed: (){

                      },
                      backgroundColor: Color(0xFF5ABFA3),
                      label: Text('Place Order')),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
          CircleAvatar(
            backgroundColor: Color(0xFF5ABFA3),
            radius: 38,
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/profile.png'),
              backgroundColor: Colors.transparent,
            ),
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
