import 'package:flutter/material.dart';

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
            'Order Details',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 7),
              child: Text(
                'Order Number 12345678',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 20),
              child: Text(
                'Table Number 33',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: 100,
                itemCount: item.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                    child: Container(
                      alignment: const Alignment(0, 0),
                      color: const Color(0xffadd9c9),
                      height: 100,
                      child: ListTile(
                        title: Text(item[index]),
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
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Items: 10',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'fourth text field',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context);
                      },
                      child: const Text('Accept'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5abfa3)),
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
