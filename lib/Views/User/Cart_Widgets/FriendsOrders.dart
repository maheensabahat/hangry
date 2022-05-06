import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

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
        List friend_emails = [];
        List friend_dishes = [];
        if (snapshot.hasData) {
          //var noteInfo = snapshot.data!.docs[1].data()! as Map;
          for (var doc in snapshot.data!.docs) {
            if ((doc.data() as Map)["qr_id"] ==
                    context.read<ScanProvider>().getQRID() &&
                (doc.data() as Map)["status"] &&
                (doc.data() as Map)["user_email"] !=
                    context.read<UserProvider>().getEmail()) {
              var email = (doc.data() as Map)["user_email"];
              var dishes = (doc.data() as Map)["selected_dishes"];
              friend_emails.add(email);
            }
          }
          return Center(
            child: SizedBox(
              height: 55,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: friend_emails.length,
                itemBuilder: (BuildContext context, int indexEmails) {
                  return friend_emails[indexEmails] == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(children: [
                          Text(friend_emails[indexEmails]),
                          // SizedBox(
                          //   height: 600,
                          //   child: ListView.builder(
                          //       physics: NeverScrollableScrollPhysics(),
                          //       itemCount: friend_dishes.length,
                          //       itemBuilder:
                          //           (BuildContext context, int indexDishes) {
                          //         return friend_dishes[indexDishes] == null
                          //             ? const Center(
                          //                 child: CircularProgressIndicator())
                          //             : ListTile(
                          //                 title: Text(friend_dishes[indexDishes]
                          //                     ["name"]));
                          //       }),
                          // )
                        ]);
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
