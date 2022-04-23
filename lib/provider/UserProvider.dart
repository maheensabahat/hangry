import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/Entities/User.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  void createUser({name, profilePicture, email}) {
    user = User(name: name, profilePicture: profilePicture, email: email);
    notifyListeners();
  }

  void setLocation(String location) {
    user.location = location;
    notifyListeners();
  }

  void setPhone(String phone) {
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

  String getFirstName() {
    return user.first;
  }

  String getLocation() {
    return user.location;
  }

  User getUser() {
    return user;
  }

  bool getQR() {
    return user.qr;
  }
}
