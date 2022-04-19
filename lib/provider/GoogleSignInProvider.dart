import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  bool isLoggedIn = false;

  Future googleLogin() async {
    isLoggedIn = false;
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = await googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    isLoggedIn = true;
    notifyListeners();
  }

  Future signOut() async {
    await googleSignIn.disconnect();
  }
}
