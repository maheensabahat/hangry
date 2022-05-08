import 'package:flutter/material.dart';
import 'package:project/Entities/Products.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:provider/provider.dart';

import '../User/Widgets/InputBox.dart';
import 'RestaurantMenu.dart';

class RestaurantAddDish extends StatefulWidget {
  bool isEdit;
  Products? product;

  RestaurantAddDish({Key? key, required this.isEdit, this.product})
      : super(key: key);

  @override
  State<RestaurantAddDish> createState() => _RestaurantAddDishState();
}

class _RestaurantAddDishState extends State<RestaurantAddDish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = 'Add Dish';

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      title = 'Edit Dish';
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      descController.text = widget.product!.desc;
      priceController.text = widget.product!.price.toString();
    }
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16),
              //   child: ProfilePicture(),
              // ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputBox(
                      label: 'Name',
                      hintText: 'Dish\'s name',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: nameController,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Description',
                      hintText: 'Dish\'s description',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: descController,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Price',
                      hintText: 'Dish\'s price per unit',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: priceController,
                      isNum: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        height: 40,
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (!widget.isEdit) {
                                var item = Products(
                                  name: nameController.text,
                                  price: int.parse(priceController.text),
                                  desc: descController.text,
                                );

                                context
                                    .read<RestaurantProvider>()
                                    .addProduct(item);
                              } else {
                                widget.product!.name = nameController.text;
                                widget.product!.desc = descController.text;
                                widget.product!.price =
                                    int.parse(priceController.text);

                                context
                                    .read<RestaurantProvider>()
                                    .updateProduct(widget.product!);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RestaurantMenu()),
                              );
                            }
                          },
                          child: widget.isEdit ? Text('Save') : Text('Confirm'),
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
      ),
    );
  }
}
