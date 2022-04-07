import 'package:flutter/material.dart';
import 'package:project/Counter.dart';

class OrderItem{
  String name;
  String price;
  Counter c;
  
  OrderItem(this.name, this.price, this.c);
}

class itemsInCart extends StatefulWidget {
  const itemsInCart({Key? key}) : super(key: key);

  @override
  _itemsInCartState createState() => _itemsInCartState();
}

class _itemsInCartState extends State<itemsInCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}