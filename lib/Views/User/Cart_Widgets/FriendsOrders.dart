import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

import '../../../Entities/OrderItem.dart';

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
        List<String> friendEmails = [];
        List<OrderItem> friendDishes = [];
        List<String> image = [];
        List<String> name = [];
        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            if (doc["qr_id"] == context.read<ScanProvider>().getQRID() &&
                doc["status"] == true &&
                doc["user_email"] != context.read<UserProvider>().getEmail()) {
              List dishes = doc.get("selected_dishes");
              String email = doc.get("user_email");
              image.add(doc.get("user_picture"));
              name.add(doc.get("user_name"));
              friendEmails.add(email);
              for (var data in dishes) {
                OrderItem order = OrderItem(
                    user_id: email,
                    name: data["name"],
                    desc: data["desc"],
                    price: data["price"],
                    quantity: data["quantity"]);
                friendDishes.add(order);
              }
              print(name);
              print(image);
              print(friendDishes);
              print(friendDishes.length);
            }
          }
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: friendEmails.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(friendEmails[0]),
                          subtitle: Text(friendDishes[index].name),
                        );
                      })),
                )
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
