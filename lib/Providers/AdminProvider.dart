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

  // Future<void> updateRestDetails(
  //     {required String email, required String qr_id}) async {
  //   await FirebaseFirestore.instance
  //       .collection('Restaurants')
  //       .where("email", isEqualTo: Restemail)
  //   isLoaded = false;
  //   notifyListeners();
  //
  //   await networkCall.updateRestDetails(r);
  //
  //   isLoaded = true;
  //   notifyListeners();
  // }

  Future updateRest(
      {required String email,
      required String name,
      required String cuisine,
      required String imageUrl,
      required String desc}) async {
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection("Restaurants")
            .doc(doc.id)
            .update({
          "name": name,
          "cuisine": cuisine,
          "image": imageUrl,
          "desc": desc,
        });
      }
    });
  }

//   Future deleteRest({required String email}) async {
//     await FirebaseFirestore.instance
//         .collection('Restaurants')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//           querySnapshot.data.documents[index]
//               .delete();
//     };
//
//
// }
}
