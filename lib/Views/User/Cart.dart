import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/Widgets/Header.dart';
import 'package:provider/provider.dart';

import '../../Entities/User.dart';
import 'Cart_Widgets/FriendsOrders.dart';
import 'Cart_Widgets/MyOrderWidget.dart';
import 'Cart_Widgets/TotalSummary.dart';

class Cart extends StatefulWidget {
  User user;

  Cart({Key? key, required this.user}) : super(key: key) {
    // CurrentCart = ShoppingCart();
    // CurrentCart.friends.add(user);
  }

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Header(
                  title: 'Cart',
                  bottom: 5,
                ),
              ),
              // if (widget.user.qr) ...[
              if (context.read<UserProvider>().getQR()) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: MyOrderWidget(
                    myOrder: widget.user.currentOrder,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24, left: 36, bottom: 12),
                  child: Text(
                    'Friends',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
                const FriendsOrders(),
              ] else ...[
                const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                  'Scan Qr at a restaurant\n to activate cart.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xA0154038),
                      fontSize: 13,
                  ),
                ),
                    ))
              ],
            ],
          ),
          if (context.read<UserProvider>().getQR()) ...[
            Padding(
              padding: const EdgeInsets.only(right: 32, bottom: 15),
              child: Summary(),
            ),
          ],
        ],
      ),
    );
  }
}
