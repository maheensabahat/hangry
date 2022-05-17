import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:provider/provider.dart';

import '../../Entities/Category.dart';
import '../../Entities/Restaurant.dart';
import '../../Entities/User.dart';
import '../../Providers/UserProvider.dart';
import 'Home_Widgets/Categories.dart';
import 'Home_Widgets/HomeHeader.dart';
import 'Home_Widgets/RestaurantDisplay.dart';
import 'Home_Widgets/SearchBar.dart';
import 'ScanQR.dart';
import 'UserMenu.dart';

class Home extends StatefulWidget {
  User user;

  Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> Categories = [
    Category(Icon(Icons.soup_kitchen), 'Chinese'),
    Category(Icon(Icons.fastfood), 'Fast food'),
    Category(Icon(Icons.local_cafe_sharp), 'Cafe'),
    Category(Icon(Icons.dinner_dining), 'Italian'),
  ];

  List<Restaurant> restaurants = [];
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getRestaurants();
    return Consumer<UserProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              FadeInDown(
                delay: Duration(milliseconds: 800),
                child: HomeHeader(
                  userName: context.read<UserProvider>().getFirstName(),
                ),
              ),

              //Search Bar
              FadeInLeft(
                  delay: Duration(milliseconds: 800),
                  child: SearchBar(
                    getRestaurants: (Restaurants) {
                      restaurants = Restaurants as List<Restaurant>;
                      isSearch = true;
                      setState(() {});
                    },
                    refresh: (refresh) {
                      if (refresh) {
                        isSearch = false;
                        setState(() {});
                      }
                    },
                  )),

              ScanQR_ViewMenu(user: widget.user),

              //Categories - heading
              FadeInRight(
                delay: Duration(milliseconds: 800),
                child: const Padding(
                  padding: EdgeInsets.only(top: 5, left: 24),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      // color: Color(0xFF5ABFA3),
                    ),
                  ),
                ),
              ),

              //Categories ListView
              CategoriesList(
                list: Categories,
                refresh: (bool) {
                  isSearch = bool;
                  setState(() {});
                },
                getRestaurants: (Restaurants) {
                  restaurants = Restaurants as List<Restaurant>;
                  isSearch = true;
                  setState(() {});
                },
              ),

              //Restaurants
              FadeInLeft(
                  delay: Duration(milliseconds: 800),
                  child: RestaurantDisplay(
                      restaurants:
                          isSearch ? restaurants : provider.restaurants))
            ],
          ),
        ),
      );
    });
  }
}

class ScanQR_ViewMenu extends StatefulWidget {
  User user;

  ScanQR_ViewMenu({Key? key, required this.user}) : super(key: key);

  @override
  _ScanQR_ViewMenuState createState() => _ScanQR_ViewMenuState();
}

class _ScanQR_ViewMenuState extends State<ScanQR_ViewMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 2, 24, 0),
      child: Stack(alignment: Alignment.topLeft, children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FadeInRight(
              delay: Duration(milliseconds: 500),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0x305ABFA3),
                      Color(0x205ABFA3),
                      Color(0x0F5ABFA3),
                      Color(0x305ABFA3)
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          !widget.user.qr
                              ? 'At a restaurant?'
                              : 'Place you order now',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          !widget.user.qr
                              ? 'Scan QR'
                              : context
                                      .read<RestaurantProvider>()
                                      .restaurant
                                      .name +
                                  " Menu",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        FadeInLeft(
          delay: Duration(milliseconds: 900),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('assets/Pasta.png')),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: FadeInRight(
                  delay: Duration(milliseconds: 600),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                ),
                onTap: () {
                  if (widget.user.qr) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserMenu(
                              user: context.read<UserProvider>().getUser(),
                              scanned: context.read<UserProvider>().getQR(),
                              restaurant: context
                                  .read<RestaurantProvider>()
                                  .getRestaurant(
                                    context
                                        .read<ScanProvider>()
                                        .getScannedEmail(),
                                  ),
                            )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScanQR(
                              user: widget.user,
                            )));
                  }
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
