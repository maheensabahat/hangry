import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Models/UserModel.dart';

import '../Entities/User.dart';
import 'package:flutter/material.dart';

abstract class NetworkCall {
  Future<String> getUsers();

  Future<bool> checkUser(String email);

  Future addUser(User user);

  Future<String> getUser(String email);
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
        userQuery = jsonEncode(doc.data());
      });
      return userQuery;
    });
    return userQuery;
  }
}
