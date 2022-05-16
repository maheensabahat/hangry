import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/User.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:provider/provider.dart';
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

                singleFriendDishes.add(order);
              }
              allFriendsDishes.add(singleFriendDishes);
            }
            allEmails = friendEmails;
          }
          return !order_status.contains(false) &&
                  order_status.isNotEmpty &&
                  context.read<OrdersProvider>().checkMyOrderStatus()
              ? AlertDialog(
                  title: const Text('Order Confirmed'),
                  content: const Text(
                      "Everyone finalized their orders. Your order will now be placed"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<UserProvider>().setQR(false);
                          allEmails
                              .add(context.read<UserProvider>().getEmail());
                          for (String email in allEmails) {
                            context
                                .read<ScanProvider>()
                                .updateQRStatusInFirebase(
                                    email: email,
                                    qr_id:
                                        context.read<ScanProvider>().getQRID(),
                                    status: false);
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Home(
                          //           user: context
                          //               .read<UserProvider>()
                          //               .getUser())),
                          // ).then((_) => setState((() {})));
                        },
                        child: const Text('Go Ahead'))
                  ],
                )
              : Center(
                  child: friendEmails.isEmpty
                      ? const Text("No Friend has joined yet",
                          style: TextStyle(
                            color: Color(0xA0154038),
                            fontSize: 12,
                          ))
                      : SizedBox(
                          height: 400 * friendEmails.length - 1,
                          child: ListView.builder(
                              itemCount: friendEmails.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, emailIndex) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 16, 0),
                                  child: Container(
                                    height: 330,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 310,
                                            decoration: const BoxDecoration(
                                              color: Color(0xF0ADD9C9),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(45),
                                                  bottomRight:
                                                      Radius.circular(30)),
                                            ),
                                          ),
                                        ),
                                        Picture(
                                            radius: 40,
                                            border: 4,
                                            image: image[emailIndex]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100, top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name[emailIndex],
                                                style: const TextStyle(
                                                    color: Color(0xFF154038),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              order_status[emailIndex]
                                                  ? const Text(
                                                      "have finalized their order",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF154038),
                                                          fontSize: 14,
                                                          fontStyle:
                                                              FontStyle.italic))
                                                  : const Text('is deciding..',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF154038),
                                                          fontSize: 14,
                                                          fontStyle:
                                                              FontStyle.italic))
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: SizedBox(
                                              width: 300,
                                              height: 150,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount:
                                                    allFriendsDishes[emailIndex]
                                                        .length,
                                                itemBuilder: (context, index) =>
                                                    Container(
                                                  height: 70,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                    color: Color(0x905ABFA3),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        blurRadius: 4,
                                                        spreadRadius: 2,
                                                        offset:
                                                            const Offset(4, 4),
                                                      )
                                                    ],
                                                  ),
                                                  child: LimitedBox(
                                                    //to solve proble of row in list view
                                                    maxHeight: 100.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 16),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        allFriendsDishes[emailIndex][index]
                                                                            .image,
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  allFriendsDishes[
                                                                              emailIndex]
                                                                          [
                                                                          index]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF154038),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  "\$" +
                                                                      allFriendsDishes[emailIndex]
                                                                              [
                                                                              index]
                                                                          .price
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF154038),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Counter(
                                                            onChangeValue:
                                                                (value) {
                                                              var f =
                                                                  allFriendsDishes[
                                                                      emailIndex];
                                                              if (value != 0) {
                                                                f[index].quantity =
                                                                    value;
                                                              } else {
                                                                f.remove(
                                                                    f[index]);
                                                              }
                                                              context.read<ScanProvider>().addToOrderFirebase(
                                                                  email: friendEmails[
                                                                      emailIndex],
                                                                  qr_id: context
                                                                      .read<
                                                                          ScanProvider>()
                                                                      .getQRID(),
                                                                  orders: f);
                                                              setState(() {});
                                                            },
                                                            // item: allFriendsDishes[
                                                            // emailIndex]
                                                            // [index],
                                                            min: 0,
                                                            max: 5,
                                                            value: allFriendsDishes[
                                                                        emailIndex]
                                                                    [index]
                                                                .quantity,
                                                            increments: 1,
                                                            canEdit: false,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 24, bottom: 45),
                                              child: Text(
                                                'Total: ' +
                                                    '  ' +
                                                    '\$' +
                                                    context
                                                        .watch<ScanProvider>()
                                                        .Total(allFriendsDishes[
                                                            emailIndex])
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Color(0xFF154038),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ),
                );
        } else {
          return Loader();
        }
      },
    );
  }
}
