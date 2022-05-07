import 'package:flutter/material.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/Restaurant/Order_history.dart';
import 'package:project/Views/Restaurant/RestaurantMenu.dart';
import 'package:project/Views/Restaurant/TableReservations.dart';
import 'package:provider/provider.dart';

import '../../Providers/GoogleSignInProvider.dart';
import '../../main.dart';
import 'RestaurantDetails.dart';
import 'TableReservations.dart';

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
          InkWell(
            child: Icon(
              Icons.logout,
              color: Color(0xFF5ABFA3),
            ),
            onTap: () {
              context.read<GoogleSignInProvider>().signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: '')),
              );
            },
          ),
          Container(
            child: Image.asset(
              'assets/chef.png',
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
                      context.read<RestaurantProvider>().getProducts();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestaurantMenu()),
                      );
                    },
                    child: const Text('Menu'),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xFF154038),
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
                            builder: (context) => const Order_history()),
                      );
                    },
                    child: const Text('Orders'),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xFF154038),
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
                        onPrimary: Color(0xFF154038),
                        primary: const Color(0xff5abfa3)),
                  ),
                ),
              ),
            ],
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
                        builder: (context) => const RestaurantDetails()),
                  );
                },
                child: const Text('Details'),
                style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFF154038),
                    primary: const Color(0xff5abfa3)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
