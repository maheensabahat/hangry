import 'package:flutter/cupertino.dart';

import '../NetworkLayer/AdminNetworkCall.dart';

class AdminProvider extends ChangeNotifier {
  late List admins;
  bool isLoaded = false;
  late List restaurants;

  ANetworkCall networkCall = AFirebaseNetworkCall();

  Future<void> getAdmins() async{
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
}
