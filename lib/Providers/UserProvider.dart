import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Entities/User.dart';
import '../Models/UserModel.dart';
import '../NetworkLayer/NetworkCall.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  NetworkCall networkCall = FirebaseNetworkCall();

  void createUser({name, profilePicture, email}) {
    user = User(name: name, profilePicture: profilePicture, email: email);
    notifyListeners();
  }

  void setLocation(String? location) {
    user.location = location;
    notifyListeners();
  }

  void setPhone(int? phone) {
    user.phone = phone;
    notifyListeners();
  }

  void setName(String name) {
    user.name = name;
    notifyListeners();
  }

  void setQR(bool status) {
    user.qr = status;
    notifyListeners();
  }

  String getName() {
    return user.name!;
  }

  String getEmail() {
    return user.email!;
  }

  String getFirstName() {
    return user.first;
  }

  String? getLocation() {
    return user.location;
  }

  User getUser() {
    return user;
  }

  bool getQR() {
    return user.qr;
  }

  String? getImage() {
    return user.profilePicture;
  }

  Future checkUser(String? email) async {
    // Firebase API call
    if (email != null) {
      var response = await networkCall.checkUser(email);
      return response;
    }
    notifyListeners();
  }

  Future addUser(User user) async {
    // Firebase API call
    await networkCall.addUser(user);
    notifyListeners();
  }



  Future getUserFromDB(String email) async {
    var response = await networkCall.getUser(email);
    Map<String, dynamic> userMap = jsonDecode(response);

    UserModel userModel = UserModel.fromJson(userMap);
    if (userModel != null) {
      this.user = User(
          name: userModel.name,
          profilePicture: userModel.image,
          email: userModel.email);
      setLocation(userModel.location);
      setPhone(userModel.phone);
    }
    notifyListeners();
  }
}
