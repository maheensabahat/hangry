import 'package:flutter/material.dart';
import 'package:project/Counter.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 20),
            child: Text(
              'Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MyUnplacedOrder(),
          ),
          Counter(min: 0, max: 5, value: 0, increments: 1)
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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFFADD9C9),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), bottomRight: Radius.circular(30)),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'are deciding..',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        )
      ],
    );
  }
}

