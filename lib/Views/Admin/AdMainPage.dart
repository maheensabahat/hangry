import 'package:flutter/material.dart';
import 'package:project/Views/Admin/AdAdmins.dart';
import 'package:project/Views/Admin/AdRestaurants.dart';
import 'package:provider/provider.dart';
import '../../Providers/GoogleSignInProvider.dart';
import '../../main.dart';

class AdMainPage extends StatefulWidget {
  const AdMainPage({Key? key}) : super(key: key);

  @override
  State<AdMainPage> createState() => _AdMainPageState();
}

class _AdMainPageState extends State<AdMainPage> {
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //     height: 50,
              //     width: 80,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         // context.read<RestaurantProvider>().getProducts();
              //         // Navigator.push(
              //         //   context,
              //         //   MaterialPageRoute(
              //         //       builder: (context) => const RestaurantMenu()),
              //         // );
              //       },
              //       child: const Text('Users'),
              //       style: ElevatedButton.styleFrom(
              //           onPrimary: Color(0xFF154038),
              //           primary: const Color(0xff5abfa3)),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdRestaurants()),
                      );
                    },
                    child: const Text('Restaurants'),
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
                            builder: (context) => const AdAdmins()),
                      );
                    },
                    child: const Text('Admins'),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xFF154038),
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