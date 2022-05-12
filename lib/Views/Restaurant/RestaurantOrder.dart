import 'package:flutter/material.dart';
import 'package:project/Views/Restaurant/Widgets/BackButton.dart';

import 'RestaurantHome.dart';

class RestaurantOrder extends StatefulWidget {
  const RestaurantOrder({Key? key}) : super(key: key);

  @override
  State<RestaurantOrder> createState() => _RestaurantOrderState();
}

class _RestaurantOrderState extends State<RestaurantOrder> {
  List item = [
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
    'item',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Back(
              route: MaterialPageRoute(builder: (context) => RestaurantHome()),
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Order Details',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Text(
                'Order Number 12345678',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                'Table Number: 33',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: 100,
                itemCount: item.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                    child: Container(
                      alignment: const Alignment(0, 0),
                      decoration: BoxDecoration(
                          color: const Color(0x505ABFA3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 80,
                      child: ListTile(
                        title: Text(
                          item[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Price comes here'),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff5abfa3),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 120,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Items: 10',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Total: \$20',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RestaurantHome()),
                        );
                      },
                      child: const Text('Serve'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5abfa3),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
