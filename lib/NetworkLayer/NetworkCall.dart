import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Models/RestaurantModel.dart';
import 'package:project/Models/UserModel.dart';
import '../Entities/Restaurant.dart';
import '../Entities/User.dart';
import 'package:flutter/material.dart';

import '../Models/OrdersModel.dart';

abstract class NetworkCall {
  Future<String> getUsers();

  Future<bool> checkUser(String email);

  Future addUser(User user);

  Future<String> getUser(String email);

  Future<void> generateRequest(User user, ReservationRequest request);

  Future<List<ReservationRequest>> getRequests(User user, String status);

  Future updatePic(String email, String imageUrl);

  Future<List<RestaurantModel>> getRestaurants();

  Future<List> getFavs(User user);

  Future<void> addFav(User user, var restaurant_id);

  Future<void> removeFav();


  var ID;
}

class FirebaseNetworkCall implements NetworkCall {
  @override
  Future<String> getUsers() async {
    // Firebase implementation
    // collection("users").get();

    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      String userQuery = querySnapshot.toString();
      return userQuery;
    });

    return "";
  }

  Future<void> addUser(User user) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    UserModel userModel = UserModel(
        name: user.name,
        email: user.email,
        location: user.location,
        phone: user.phone,
        image: user.profilePicture);

    return users
        .add(userModel.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<bool> checkUser(String email) async {
    var myMapQuery = (await FirebaseFirestore.instance
        .collection("Users")
        .where('email', isEqualTo: email));

    var querySnapshot = await myMapQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals == 1;
  }

  @override
  Future<String> getUser(String email) async {
    String userQuery = "";
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        ID = doc.id;
        userQuery = jsonEncode(doc.data());
      });
      return userQuery;
    });
    return userQuery;
  }

  @override
  var ID;

  @override
  Future<void> generateRequest(User user, ReservationRequest request) async {
    CollectionReference reqs =
        FirebaseFirestore.instance.collection('Reservations');

    await reqs.add(request.toJson()).then((value) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.docID)
          .collection('Reservations')
          .add(request.ID(value.id));
      print("Request Added, ${value.id}");
    }).catchError((error) => print("Failed to add request: $error"));
  }

  Future<List<ReservationRequest>> getRequests(User user, String status) async {
    List<ReservationRequest> reqs = [];

    List ids = await getReqID(user);

    int i = 0;
    while (i < ids.length) {
      ReservationRequest r =
          await getRequestusingID(ids[i], status) as ReservationRequest;
      if (r != null) {
        reqs.add(r);
      }
      i++;
    }

    print("y" + reqs.toString());
    return reqs;
  }

  Future<ReservationRequest?> getRequestusingID(var id, String status) async {
    var x = await FirebaseFirestore.instance
        .collection('Reservations')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      ReservationRequest req = ReservationRequest.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
      print(req);
      if (req.status == status) {
        return req;
      } else {
        return null;
      }
    });

    return x;
  }

  getReqID(User user) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.docID)
        .collection('Reservations')
        .get();

    final thedetails = query.docs
        .map((DocumentSnapshot e) => UserModel.reservationReqs_fromJson(
            e.data() as Map<String, dynamic>))
        .toList();

    print(thedetails);
    return thedetails;
  }

  Future updatePic(String email, String imageUrl) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    await users
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(doc.id)
            .update({
          "image": imageUrl,
        });
      }
    });
        }

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    List<RestaurantModel> restaurants = [];

    await FirebaseFirestore.instance
        .collection('Restaurants')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var restModel =
            RestaurantModel.fromJson(doc.data() as Map<String, dynamic>);
        restModel.id = doc.id;
        restaurants.add(restModel);
      });
    });
    return restaurants;
  }

  @override
  Future<void> addFav(User user, var restaurant_id) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    await users
        .doc(user.docID)
        .collection('Favourites')
        .add(UserModel.ID_toJson(restaurant_id));
    print("Favourite Added}");
  }

  @override
  Future<List> getFavs(User user) async {
    List Fav = [];

    List ids = await getIDs(user);

    int i = 0;
    while (i < ids.length) {
      RestaurantModel? r = await getFavUsingID(ids[i]);
      if (r != null) {
        Fav.add(r);
      }
      i++;
    }
    return Fav;
  }

  Future<RestaurantModel?> getFavUsingID(var id) async {
    var r;

    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      r = RestaurantModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    });

    return r;
  }

  Future<List> getIDs(User user) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.docID)
        .collection('Favourites')
        .get();

    final thedetails = query.docs
        .map((DocumentSnapshot e) =>
            UserModel.ID_fromJson(e.data() as Map<String, dynamic>))
        .toList();

    return thedetails;
  }

  @override
  Future<void> removeFav() {
    // TODO: implement removeFav
    throw UnimplementedError();
  }

  // Future<List<OrdersModel>> getOrderDetails(UserId) async {
  //   List<OrdersModel> orders = [];
  //
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(UserId)
  //       .collection('Orders')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       OrdersModel order =
  //       OrdersModel.fromJson(doc.data() as Map<String, dynamic>);
  //       order.ID = doc.id;
  //       orders.add(order);
  //     });
  //   });
  //   return orders;
  // }
}
