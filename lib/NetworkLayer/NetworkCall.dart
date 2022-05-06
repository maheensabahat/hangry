import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Models/UserModel.dart';

import '../Entities/User.dart';
import 'package:flutter/material.dart';

abstract class NetworkCall {
  Future<String> getUsers();

  Future<bool> checkUser(String email);

  Future addUser(User user);

  Future<String> getUser(String email);

  Future<void> generateRequest(User user, ReservationRequest request);

  Future<List<ReservationRequest>> getRequests(User user, String status);

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
    while(i < ids.length){
      ReservationRequest r = await getRequestusingID(ids[i], status) as ReservationRequest;
      if(r != null){
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
}
