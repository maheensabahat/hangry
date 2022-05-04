import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;
  bool isLoggedIn = true;
  bool isLoaded = false;
  bool _isRestaurant = false;
  List<String> restaurantEmails = [];
  late User appUser;

  Future googleLogin() async {
    isLoggedIn = false;
    notifyListeners();

    final googleUser = await googleSignIn.signIn().catchError((onError) {
      print("Error $onError");
    });

    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      print("Error $onError");
    });

    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('RestaurantEmails')
          .get()
          .then((QuerySnapshot querySnapshot) {
        restaurantEmails.clear();
        for (var doc in querySnapshot.docs) {
          restaurantEmails.add(doc["email"]);
        }
      });
      if (restaurantEmails.contains(_user!.email)) {
        _isRestaurant = true;
      } else {
        _isRestaurant = false;
      }
    }
    isLoggedIn = true;
    notifyListeners();
  }

  Future signOut() async {
    await googleSignIn.disconnect().catchError((onError) {
      print("Error $onError");
    });
    isLoggedIn = true;
    notifyListeners();
  }

  // if (_user != null) {
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('Tasks').get();
  //     final allemails = querySnapshot.docs.map((doc) => doc.data()).toList();
  //     isRestaurant = true;
  //     if (allemails.contains(_user!.email)) {
  //       isRestaurant = true;
  //     }
  //   }

  bool checkRestaurant() {
    return _isRestaurant;
  }
}
