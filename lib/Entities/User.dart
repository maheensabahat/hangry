import 'package:flutter/material.dart';

class User{
  String Name;
  int phone;
  String Location;
  late Image dp;
  //Cart
  //Orders
  //Favs

  User(this.Name, this.phone, this.Location);

  @override
  String toString() {
    return 'User{Name: $Name, phone: $phone, Location: $Location}';
  }
}