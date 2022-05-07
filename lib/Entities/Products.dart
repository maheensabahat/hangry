import 'package:flutter/material.dart';

class Products {
  String name;
  String desc;
  var ID;
  String? image;
  int price;

  Products(
      {required this.name,
      required this.desc,
      this.ID,
      this.image,
      required this.price});

  @override
  String toString() {
    return 'Products{name: $name, ID: $ID}';
  }
}
