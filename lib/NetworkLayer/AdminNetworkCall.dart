import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Entities/Restaurant.dart';

abstract class ANetworkCall {
  Future<List> getAdmins();

  Future<List> getRestaurants();

  Future updateRestDetails(Restaurant restaurant);

  Future DeleteRestaurant(Restaurant restaurant);
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

  Future<List<Restaurant>> getRestaurants() async {
    List<Restaurant> restaurants = [];

    await FirebaseFirestore.instance
        .collection('Restaurants')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var admin = jsonDecode(jsonEncode(doc.data()));
        // var name = admin['name'];
        Restaurant rest = Restaurant(
            name: admin["name"],
            desc: admin["desc"],
            category: admin["cuisine"],
            image: admin["image"]);
        rest.id = doc.id;
        restaurants.add(rest);
      });
    });
    return restaurants;
  }

  @override
  Future<void> updateRestDetails(Restaurant restaurant) async {
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurant.id)
        .update({
      'name': restaurant.name,
      'desc': restaurant.desc,
      'cuisine': restaurant.category,
      'image': restaurant.image
    }).then((value) {
      print("Restaurant Details updated.");
    }).catchError((error) => print("Failed to updated details: $error"));
  }

  @override
  Future DeleteRestaurant(Restaurant restaurant) async {
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurant.id)
        .delete();
  }
}
