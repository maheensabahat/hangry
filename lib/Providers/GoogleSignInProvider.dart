import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInProvider extends ChangeNotifier {
  late GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;
  bool isLoggedIn = true;
  bool isLoaded = false;
  bool _isRestaurant = false;
  List<String> restaurantEmails = [];
  late User appUser;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future googleLogin() async {
    isLoggedIn = false;
    notifyListeners();

    googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn().catchError((onError) {
      debugPrint("Error $onError");
    });

    if (googleUser == null) return;
    _user = googleUser;
    try {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((onError) {
        debugPrint("Error $onError");
      });
    } catch (error) {
      debugPrint("Error $Error");
    }

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
      debugPrint("Error $onError");
    });
    isLoggedIn = true;
    notifyListeners();
  }

  bool checkRestaurant() {
    return _isRestaurant;
  }
}
