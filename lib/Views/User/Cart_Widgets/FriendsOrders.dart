import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/User.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:provider/provider.dart';
import '../../../Entities/My_Order.dart';
import '../../../Entities/OrderItem.dart';
import '../../Restaurant/Widgets/Loader.dart';
import '../Widgets/ProfilePicture.dart';
import '../home.dart';
import 'Counter.dart';

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
        List<String> allEmails = [];
        List<String> friendEmails = [];
        List<List<OrderItem>> allFriendsDishes = [];
        List<String> image = [];
        List<String> name = [];
        List<bool> order_status = [];
        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            if (doc["qr_id"] == context.read<ScanProvider>().getQRID() &&
                doc["qr_status"] == true &&
                doc["user_email"] != context.read<UserProvider>().getEmail()) {
              List dishes = doc.get("selected_dishes");
              String email = doc.get("user_email");
              image.add(doc.get("user_picture"));
              name.add(doc.get("user_name"));
              order_status.add(doc.get("order_status"));
              friendEmails.add(email);
              List<OrderItem> singleFriendDishes = [];
              for (var data in dishes) {
                OrderItem order = OrderItem(
                    user_id: email,
                    name: data["name"],
                    desc: data["desc"],
                    price: data["price"] as int,
                    quantity: data["quantity"]);
                order.image = data["image"];
                order.ProductID = data["product_id"];

                singleFriendDishes.add(order);
              }
              allFriendsDishes.add(singleFriendDishes);
            }
            allEmails = friendEmails;
          }
          return !order_status.contains(false) &&
                  order_status.isNotEmpty &&
                  context.read<OrdersProvider>().checkMyOrderStatus()
              ? Container(
                  height: 130,
                  child: Center(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Order Confirmed',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Everyone finalized their orders.\n Orders are being sent to restaurant.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xA0154038),
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 35,
                            child: FloatingActionButton.extended(
                              backgroundColor: Color(0xFF5ABFA3),
                              onPressed: () {
                                context
                                    .read<OrdersProvider>()
                                    .addFinalOrdersToFirebase(
                                        context.read<ScanProvider>().getQRID(),
                                        context.read<UserProvider>().getEmail(),
                                        context
                                            .read<ScanProvider>()
                                            .getOrderList());

                                context
                                    .read<ScanProvider>()
                                    .updateQRStatusInFirebase(
                                        email: context
                                            .read<UserProvider>()
                                            .getEmail(),
                                        qr_id: context
                                            .read<ScanProvider>()
                                            .getQRID(),
                                        status: false);

                                // print(context.read<ScanProvider>().getOrderList());

                                int i = 0;

                                for (String email in friendEmails) {
                                  context
                                      .read<ScanProvider>()
                                      .updateQRStatusInFirebase(
                                          email: email,
                                          qr_id: context
                                              .read<ScanProvider>()
                                              .getQRID(),
                                          status: false);

                                  context
                                      .read<OrdersProvider>()
                                      .addFinalOrdersToFirebase(
                                          context
                                              .read<ScanProvider>()
                                              .getQRID(),
                                          email,
                                          allFriendsDishes[i]);

                                  // print(allFriendsDishes[i]);
                                  i++;
                                }
                                context
                                    .read<OrdersProvider>()
                                    .setMyOrderStatus(false);
                              },
                              label: Text('Ok'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: friendEmails.isEmpty
                      ? Container(
                          height: 130,
                          child: const Text(
                            "No Friend has joined yet",
                            style: TextStyle(
                              color: Color(0xA0154038),
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 42),
                          child: SizedBox(
                            height: 130,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: friendEmails.length,
                              itemBuilder: ((context, emailIndex) {
                                MyOrder friend = MyOrder();
                                friend.isPlaced = order_status[emailIndex];
                                friend.list = allFriendsDishes[emailIndex];
                                return Order(
                                    name: name[emailIndex],
                                    order: friend,
                                    image: image[emailIndex]);
                              }),
                            ),
                          ),
                        ),
                );
        } else {
          return Loader();
        }
      },
    );
  }
}
