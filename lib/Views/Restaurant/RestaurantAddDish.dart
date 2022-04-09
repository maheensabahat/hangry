import 'package:flutter/material.dart';
import 'package:project/Views/User/Widgets/InputBox.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';

import 'RestaurantMenu.dart';

class RestaurantAddDish extends StatefulWidget {
  bool isEdit;

  RestaurantAddDish({Key? key, required this.isEdit}) : super(key: key);

  @override
  State<RestaurantAddDish> createState() => _RestaurantAddDishState();
}

class _RestaurantAddDishState extends State<RestaurantAddDish> {
  String title = 'Add Dish';

  @override
  void initState() {
    super.initState();
    if(widget.isEdit){
      title = 'Edit Dish';
    }
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ProfilePicture(),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: InputBox(
                        label: 'Name',
                        hintText: "dish's name",
                        icon: Icon(Icons.edit),
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: InputBox(
                        label: 'Description',
                        hintText: "dish's description",
                        icon: Icon(Icons.edit),
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: InputBox(
                        label: 'Category',
                        hintText: "dish's Category",
                        icon: Icon(Icons.edit),
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: InputBox(
                        label: 'Price',
                        hintText: "dish's price per unit",
                        icon: Icon(Icons.edit),
                        controller: TextEditingController()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: SizedBox(
                      height: 40,
                      width: 110,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RestaurantMenu()),
                          );
                        },
                        child:
                            widget.isEdit ? Text('Save') : Text('Confirm'),
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
      ),
    );
  }
}
