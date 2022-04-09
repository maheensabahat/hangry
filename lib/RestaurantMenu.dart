import 'package:flutter/material.dart';
import 'package:project/RestaurantAddDish.dart';
import 'package:project/RestaurantEditDish.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({Key? key}) : super(key: key);

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  List items = [
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish',
    'Dish'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
            'Menu',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5abfa3),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RestaurantAddDish()),
          );
        },
      ),
      body: Center(
        child: ListView.builder(
          itemExtent: 100,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xffadd9c9)),
                height: 100,
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: InkWell(
                    child: ListTile(
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RestaurantEditDish()),
                          );
                        },
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: 100,
                          width: 70,
                          color: const Color(0xff5abfa3),
                        ),
                      ),
                      tileColor: const Color(0xffadd9c9),
                      title: Text(
                        items[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: const Text('This is a dish',
                          style: TextStyle(color: Colors.black)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestaurantEditDish()),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
