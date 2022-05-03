import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendsOrders extends StatefulWidget {
  const FriendsOrders({Key? key}) : super(key: key);

  @override
  State<FriendsOrders> createState() => _FriendsOrdersState();
}

class _FriendsOrdersState extends State<FriendsOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Scanned")
          .snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        var noteInfo = snapshot.data!.docs[1].data()! as Map;
        if (snapshot.hasData) {
          return Center(
            child: Text(noteInfo.toString()),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
