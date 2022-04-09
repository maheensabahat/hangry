import 'package:flutter/material.dart';
import 'package:project/RestaurantMenu.dart';
import 'package:project/RestaurantOrder.dart';
import 'package:project/TableReservations.dart';

class RestaurantHome extends StatefulWidget {
  const RestaurantHome({Key? key}) : super(key: key);

  @override
  State<RestaurantHome> createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              'assets/Chef.png',
              width: 500,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestaurantMenu()),
                      );
                    },
                    child: const Text('Menu'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5abfa3)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestaurantOrder()),
                      );
                    },
                    child: const Text('Orders'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5abfa3)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableReservations()),
                      );
                    },
                    child: const Text('Tables'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5abfa3)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
