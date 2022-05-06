import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/ShoppingCart.dart';
import 'package:project/Views/User/Widgets/Header.dart';

import '../../Entities/User.dart';
import 'Cart_Widgets/FriendsOrders.dart';
import 'Cart_Widgets/MyOrderWidget.dart';
import 'Cart_Widgets/Order.dart';
import 'Cart_Widgets/TotalSummary.dart';

class Cart extends StatefulWidget {
  late ShoppingCart CurrentCart;
  User user;

  Cart({Key? key, required this.user}) : super(key: key) {
    CurrentCart = ShoppingCart();
    CurrentCart.friends.add(user);
  }

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Header(
              title: 'Cart',
              bottom: 0,
            ),
          ),
          if (widget.user.qr) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MyOrderWidget(
                myOrder: widget.user.currentOrder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 36, bottom: 12),
              child: Text(
                'Friends',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            FriendsOrders(),
            Padding(
              padding: const EdgeInsets.only(left: 42, right: 42, bottom: 26),
              child: Container(
                height: 100,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.CurrentCart.friends.length - 1,
                  itemBuilder: (context, index) {
                    User friend = widget.CurrentCart.friends[index];
                    if (index != 0) {
                      return Order(
                          name: friend.name!, order: friend.currentOrder);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 36),
              child: Summary(cart: widget.CurrentCart),
            ),
          ] else ...[
            Center(
                child: Text(
              'Empty Cart',
            ))
          ],
        ],
      ),
    );
  }
}
