import 'package:flutter/material.dart';
import 'package:project/RestaurantMenu.dart';

class RestaurantEditDish extends StatefulWidget {
  const RestaurantEditDish({Key? key}) : super(key: key);

  @override
  State<RestaurantEditDish> createState() => _RestaurantEditDishState();
}

class _RestaurantEditDishState extends State<RestaurantEditDish> {
  final _formKey = GlobalKey<FormState>();
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
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Edit Dish Details',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            alignment: const Alignment(0, 0),
            child: const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xff5abfa3),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Dish Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Description',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Category',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Price',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: SizedBox(
                    height: 35,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RestaurantMenu()),
                        );
                      },
                      child: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5abfa3)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
