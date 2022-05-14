import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Entities/User.dart';
import 'package:project/Entities/My_Order.dart';
import 'package:project/Providers/GoogleSignInProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/ReserveTable.dart';
import 'package:provider/provider.dart';

import '../../Entities/My_Order.dart';
import '../../Entities/My_Order.dart';
import '../../Providers/RestaurantProvider.dart';
import 'ScanQR.dart';
import 'Widgets/RestaurantBanner.dart';

class UserMenu extends StatefulWidget {
  bool scanned;
  Restaurant restaurant;
  User user;
  late String data;

  UserMenu(
      {Key? key,
      required this.user,
      required this.scanned,
      required this.restaurant,
      data = ""})
      : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false)
        .setRestaurant(widget.restaurant);
    Provider.of<RestaurantProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image Banner
                RestaurantBanner(
                    Name: widget.restaurant.name,
                    Cuisine: widget.restaurant.category,
                    image: widget.restaurant.image),

                //Heading
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                //Menu
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 30),
                    child: Consumer<RestaurantProvider>(
                      builder: (context, provider, child) {
                        var menu = provider.restaurant.items;
                        return (provider.isLoaded)
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                itemExtent: 100,
                                itemCount: menu.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 0, 25, 15),
                                    child: FadeInDown(
                                      delay: Duration(
                                          milliseconds: 800 * (index + 1)),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0x405ABFA3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        height: 100,
                                        child: Align(
                                          alignment: const Alignment(0, 0),
                                          child: ListTile(
                                            leading: Container(
                                                height: 100,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/pasta.jpg',
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                            title: Text(
                                              menu[index].name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: Text(menu[index].desc,
                                                style: TextStyle(fontSize: 13)),
                                            trailing: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (widget.scanned) ...[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: InkWell(
                                                        child: Icon(Icons
                                                            .shopping_cart),
                                                        onTap: () {
                                                          var order = OrderItem(
                                                              user_id: context
                                                                  .read<
                                                                      UserProvider>()
                                                                  .getEmail(),
                                                              name: 'Pizza',
                                                              desc:
                                                                  'Chicken Fajita',
                                                              price: 20,
                                                              quantity: 1);
                                                          context
                                                              .read<
                                                                  ScanProvider>()
                                                              .addToOrder(
                                                                  order: order);
                                                          context
                                                              .read<
                                                                  ScanProvider>()
                                                              .addToOrderFirebase(
                                                                  qr_id: context
                                                                      .read<
                                                                          ScanProvider>()
                                                                      .getQRID(),
                                                                  email: context
                                                                      .read<
                                                                          UserProvider>()
                                                                      .getEmail(),
                                                                  orders: context
                                                                      .read<
                                                                          ScanProvider>()
                                                                      .getOrderList());
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text('\$ ' +
                                                        menu[index]
                                                            .price
                                                            .toString()),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Container(
                                  child: CircularProgressIndicator(
                                    color: Color(0xffadd9c9),
                                  ),
                                  height: 50,
                                  width: 50,
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),

            //Table reservation and qr scan
            if (!widget.scanned) ...[
              Reserve_QR(user: widget.user, restaurant: widget.restaurant)
            ]
          ],
        ),

        //Back
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: BackButton());
  }
}

class Reserve_QR extends StatelessWidget {
  Restaurant restaurant;
  User user;

  Reserve_QR({Key? key, required this.user, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 165, 20, 0),
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Color(0xff51bfa3),
          child: Icon(Icons.table_restaurant),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReserveTable(
                      restaurant: restaurant,
                    )));
          },
        ),
      ),
    );
  }
}
