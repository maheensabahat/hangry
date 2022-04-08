import 'package:flutter/material.dart';

class User {
  String Name;
  late String _first;

  int phone;
  String Location;
  late Image dp;

  //Cart
  //Orders
  //Favs

  User(this.Name, this.phone, this.Location) {
    _first = Name.substring(0, Name.split(" ")[0].length);
  }

  String get first => _first;

  @override
  String toString() {
    return 'User{Name: $Name, phone: $phone, Location: $Location}';
  }
}
