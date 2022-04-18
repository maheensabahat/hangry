import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';

import 'My_Order.dart';

class User {

  //Name, phone no., location
  String Name;
  late String _first;

  int phone;
  String Location;

  //Profile picture
  late Image dp;

  //Current order
  late MyOrder currentOrder;

  //Scanned qr code at a rest or not, only one rest at a time
  bool qr = false;

  //Previous Orders

  //Favs rests



  User(this.Name, this.phone, this.Location) {
    _first = Name.substring(0, Name.split(" ")[0].length);
  }

  void CreateCart(Restaurant restaurant){
    currentOrder = MyOrder();
    currentOrder.restaurant = restaurant;
  }

  String get first => _first;

  @override
  String toString() {
    return 'User{Name: $Name, phone: $phone, Location: $Location}';
  }
}
