import 'package:flutter/material.dart';

class OrderItem{
  String name;
  String price;
  
  OrderItem(this.name, this.price);
}

class itemsInCart extends StatefulWidget {
  const itemsInCart({Key? key}) : super(key: key);

  @override
  _itemsInCartState createState() => _itemsInCartState();
}

class _itemsInCartState extends State<itemsInCart> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
