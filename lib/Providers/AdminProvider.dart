import 'package:flutter/cupertino.dart';

import '../NetworkLayer/AdminNetworkCall.dart';

class AdminProvider extends ChangeNotifier {
  late List admins;
  bool isLoaded = false;

  ANetworkCall networkCall = AFirebaseNetworkCall();

  Future<void> getAdmins() async{
    isLoaded = false;
    notifyListeners();

    admins = await networkCall.getAdmins();
    print(admins);

    isLoaded = true;
    notifyListeners();
  }
}
