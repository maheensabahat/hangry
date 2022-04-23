import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';

import 'My_Order.dart';

class User {
  //Name, phone no., location
  String name;
  late String _first;
  String phone;
  String location;

  //Profile picture
  late Image profilePicture;

  //Current order
  late MyOrder currentOrder;

  //Scanned qr code at a rest or not, only one rest at a time
  bool qr = false;

  //Previous Orders

  //Favs rests

  User(this.name, this.phone, this.location) {
    _first = name.substring(0, name.split(" ")[0].length);
  }

  void CreateCart(Restaurant restaurant) {
    currentOrder = MyOrder();
    currentOrder.restaurant = restaurant;
  }

  String get first => _first;

  @override
  String toString() {
    return 'User{Name: $name, phone: $phone, location;: $location}';
  }
}
