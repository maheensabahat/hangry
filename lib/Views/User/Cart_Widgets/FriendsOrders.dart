import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/ScanProvider.dart';
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
        List temp = [];
        if (snapshot.hasData) {
          //var noteInfo = snapshot.data!.docs[1].data()! as Map;
          for (var doc in snapshot.data!.docs) {
            if ((doc.data() as Map)["qr_id"] ==
                    context.read<ScanProvider>().getQRID() &&
                (doc.data() as Map)["status"]) {
              var email = (doc.data() as Map)["user_email"];
              temp.add(email);
            }
          }
          return Center(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: temp.length,
                itemBuilder: (BuildContext context, int index) {
                  return temp[index] == null
                      ? const Center(child: CircularProgressIndicator())
                      : ListTile(
                          title: Text(temp[index]),
                        );
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
