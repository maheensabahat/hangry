import 'package:flutter/material.dart';

class RestaurantHome extends StatefulWidget {
  const RestaurantHome({Key? key}) : super(key: key);

  @override
  State<RestaurantHome> createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: new Image.asset(
            'assets/chef.png',
            height: 60.0,
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
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RestaurantHome()),
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
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RestaurantHome()),
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
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RestaurantHome()),
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
    );
  }
}
