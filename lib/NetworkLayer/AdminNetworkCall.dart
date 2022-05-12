import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ANetworkCall {
  Future<List> getAdmins();

  Future<List> getRestaurants();
}

class AFirebaseNetworkCall implements ANetworkCall {
  @override
  Future<List> getAdmins() async {
    List admins = [];

    await FirebaseFirestore.instance
        .collection('Admin')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var admin = jsonDecode(jsonEncode(doc.data()));
        var email = admin['Email'];
        admins.add(email);
      });
    });
    return admins;
  }

  Future<List> getRestaurants() async {
    List restaurants = [];

    await FirebaseFirestore.instance
        .collection('Restaurants')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var admin = jsonDecode(jsonEncode(doc.data()));
        var name = admin['name'];
        restaurants.add(name);
        //  var r = jsonEncode(doc.data());
        //  Map<String, dynamic> map = jsonDecode(r);
        //
        // var rest = RestaurantModel.fromJson(map);
        //  restaurants.add(rest);
      });
    });
    return restaurants;
  }
}
