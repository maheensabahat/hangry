import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Models/UserModel.dart';

import '../Entities/User.dart';

abstract class NetworkCall {
  Future<String> getUsers();

  Future<bool> checkUser(String email);

  Future addUser(User user);
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
    UserModel userModel =
        UserModel(name: user.name, email: user.email, location: user.location);

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
}
