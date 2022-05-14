import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Entities/Restaurant.dart';

abstract class ANetworkCall {
  Future<List> getAdmins();

  Future<List> getRestaurants();

  // Future updateRestDetails(Restaurant restaurant);
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
        var name = admin['name'];
        Restaurant rest = Restaurant(
            id: doc["email"],
            name: admin["name"],
            desc: admin["desc"],
            category: admin["cuisine"],
            image: admin["image"]);
        restaurants.add(rest);
        //  var r = jsonEncode(doc.data());
        //  Map<String, dynamic> map = jsonDecode(r);
        //
        // var rest = RestaurantModel.fromJson(map);
        //  restaurants.add(rest);
      });
    });
    return restaurants;
  }
  // Future updateRestDetails(Restaurant restaurant) async {
  //   CollectionReference res =
  //   FirebaseFirestore.instance.collection('Restaurants');
  //
  //   await res.doc(restaurant.id).update({
  //     'name': restaurant.name,
  //     'desc': restaurant.desc,
  //     'cuisine': restaurant.category,
  //   }).then((value) {
  //     print("Details updated.");
  //   }).catchError((error) => print("Failed to updated detail: $error"));
  // }
}
