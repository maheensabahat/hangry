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
  bool _isAdmin = false;
  String restaurantEmail = "";
  String adminEmail = "";
  late User appUser;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future googleLogin() async {
    isLoggedIn = false;
    notifyListeners();

    googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn().catchError((onError) {
      debugPrint("Error $onError");
    });

    if (googleUser == null) {
      isLoggedIn = true;
      notifyListeners();
      return;
    }
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
          .collection('Restaurants')
          .where("email", isEqualTo: user!.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          restaurantEmail = doc["email"];
        }
      });
      if (restaurantEmail == _user!.email) {
        _isRestaurant = true;
      } else {
        _isRestaurant = false;
      }
    }
    if (_user != null) {
      await FirebaseFirestore.instance
          .collection('Admin')
          .where("Email", isEqualTo: user!.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          adminEmail = doc["Email"];
        }
      });

      if (adminEmail == _user!.email) {
        _isAdmin = true;
      } else {
        _isAdmin = false;
      }
    }

    isLoggedIn = true;
    notifyListeners();
  }

  Future signOut() async {
    await googleSignIn.disconnect().catchError((onError) {
      debugPrint("Error $onError");
    });

    _isRestaurant = false;
    _isAdmin = false;
    restaurantEmail = "";
    adminEmail = "";

    isLoggedIn = true;
    notifyListeners();
  }

  bool checkRestaurant() {
    return _isRestaurant;
  }

  bool checkAdmin() {
    return _isAdmin;
  }
}
