import 'package:flutter/material.dart';
import 'package:project/Views/Restaurant/RestaurantAddDish.dart';

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
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5abfa3),
        foregroundColor: Color(0xFF154038),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantAddDish(
                      isEdit: false,
                    )),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 20),
        child: Center(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemExtent: 100,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0x505ABFA3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 100,
                  child: Align(
                    alignment: const Alignment(0, 0),
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
                                builder: (context) => RestaurantAddDish(
                                      isEdit: true,
                                    )),
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
                      title: Text(
                        items[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: const Text('This is a dish',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
