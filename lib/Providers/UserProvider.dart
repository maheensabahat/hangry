import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Entities/User.dart';
import '../Entities/ReservationRequest.dart';
import '../Models/UserModel.dart';
import '../NetworkLayer/NetworkCall.dart';

class UserProvider extends ChangeNotifier {
  late User user;
  bool reqsLoaded = false;
  bool isLoaded = false;
  List<Restaurant> restaurants = [];

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
    getUserFromDB(user.email);
  }

  Future getUserFromDB(String? email) async {
    var response = await networkCall.getUser(email!);
    Map<String, dynamic> userMap = jsonDecode(response);

    UserModel userModel = UserModel.fromJson(userMap);
    if (userModel != null) {
      this.user = User(
          name: userModel.name,
          profilePicture: userModel.image,
          email: userModel.email);
      setLocation(userModel.location);
      setPhone(userModel.phone);
      user.docID = networkCall.ID;
    }
    notifyListeners();
  }

  Future<void> reserveTable(ReservationRequest request) async {
    await networkCall.generateRequest(user, request);
    notifyListeners();
  }

  Future<void> getRequests(String status) async {
    user.Pending_Reservations.clear();
    changeLoadingVar(false);

    List<ReservationRequest> r = await getReqFromDB(status);
    if (status == 'pending') {
      user.Pending_Reservations = r;
      notifyListeners();
    } else {
      user.Approved_Reservations = r;
    }

    changeLoadingVar(true);
  }

  Future<List<ReservationRequest>> getReqFromDB(String status) async {
    List<ReservationRequest> r = [];

    r = await networkCall.getRequests(this.user, status);

    return r;
  }

  Future<void> changeLoadingVar(bool bvar) async {
    reqsLoaded = bvar;
    await Future.delayed(
      Duration(milliseconds: 1),
    );
    notifyListeners();
  }

  Future<void> getRestaurants() async {
    isLoaded = false;
    await Future.delayed(
      Duration(milliseconds: 1),
    );
    notifyListeners();

    var restList = await networkCall.getRestaurants();

    restaurants = restList
        .map((e) => Restaurant(
            name: e.name,
            desc: e.desc,
            id: e.id,
            category: e.category,
            image: e.image,
            isFav: false))
        .toList();

    isLoaded = true;
    notifyListeners();
  }

  Future<void> MarkFav(Restaurant r) async {
    await networkCall.addFav(user, r.id);
  }

  Future<void> getFav() async {
    var restList = await networkCall.getFavs(user);

    user.favs = restList
        .map((e) => Restaurant(
            name: e.name,
            desc: e.desc,
            id: e.id,
            category: e.category,
            image: e.image,
            isFav: true))
        .toList();

    print(user.favs);
  }

  List<Restaurant> searchRestaurant(String s) {
    List<Restaurant> rest = [];

    restaurants.forEach((element) {
      if (element.name.toLowerCase() == s.toLowerCase()) {
        rest.add(element);
      }
    });

    return rest;
  }


}
