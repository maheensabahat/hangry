import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ANetworkCall {
  Future<List> getAdmins();
}

class AFirebaseNetworkCall implements ANetworkCall {
  @override
  Future<List> getAdmins() async {
    List admins = [];

    await FirebaseFirestore.instance
        .collection('Admin')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var admin = jsonDecode(jsonEncode(doc.data()));
        var email = admin['Email'];
        admins.add(email);
      });
    });
    return admins;
  }
}
