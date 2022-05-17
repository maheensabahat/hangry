import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Entities/Restaurant.dart';
import '../NetworkLayer/AdminNetworkCall.dart';

class AdminProvider extends ChangeNotifier {
  late List admins;
  bool isLoaded = false;
  late List restaurants;

  ANetworkCall networkCall = AFirebaseNetworkCall();

  Future<void> getAdmins() async {
    isLoaded = false;
    notifyListeners();

    admins = await networkCall.getAdmins();
    print(admins);

    isLoaded = true;
    notifyListeners();
  }

  Future<void> getRestaurants() async {
    isLoaded = false;
    notifyListeners();

    restaurants = await networkCall.getRestaurants();
    print(restaurants);

    isLoaded = true;
    notifyListeners();
  }

  Future<void> updateRestDetails(Restaurant restaurant) async {
    await networkCall.updateRestDetails(restaurant);
    getRestaurants();
  }

  Future<void> DeleteRestaurant(Restaurant restaurant) async {
    await networkCall.DeleteRestaurant(restaurant);
    getRestaurants();
  }
}
