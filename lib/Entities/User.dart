import 'package:flutter/material.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:provider/provider.dart';

import 'My_Order.dart';

class User {
  //Name, phone no., location
  String? name;
  late String _first;
  late int? phone;
  late String? location;
  String? email;
  var docID;

  //Profile picture
  String? profilePicture;

  //Current order
  late MyOrder currentOrder;

  //Scanned qr code at a rest or not, only one rest at a time
  bool qr = false;

  //Previous Orders
  List<ReservationRequest> Approved_Reservations = [];
  List<ReservationRequest> Pending_Reservations = [];

  //Favs rests
  List<Restaurant> favs = [];

  User({this.name, this.profilePicture, this.email}) {
    _first = name!.substring(0, name!.split(" ")[0].length);
  }

  void setPhone(int phone) {
    this.phone = phone;
  }

  void setLocation(String location) {
    this.location = location;
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
