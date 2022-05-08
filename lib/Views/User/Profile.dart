import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/User/MyOrders.dart';
import 'package:project/Views/User/Widgets/Restauarant_Widget.dart';
import 'package:provider/provider.dart';
import '../../Providers/UserProvider.dart';
import 'User_TableReservations.dart';

import '../../Entities/Restaurant.dart';
import '../../Entities/User.dart';

import 'Favorites.dart';
import 'Widgets/Header.dart';
import 'Widgets/ProfilePicture.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<RestaurantWidget> fav = [
    RestaurantWidget(
      restaurant: Restaurant(
        name: "Xander's",
        desc:
            "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
        category: 'Cafe',
        isFav: true,
        image: 'assets/restaurant.jpg',
      ),
    ),
    RestaurantWidget(
      restaurant: Restaurant(
        name: "Xander's",
        desc:
            "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
        category: 'Cafe',
        isFav: true,
        image: 'assets/restaurant.jpg',
      ),
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Header(
                    title: 'Profile',
                    bottom: 25,
                  ),
                  ProfilePicture(),
                  ProfileDetails()
                ],
              ),
            ),
            ButtonMenu(),
            FavListView(favourites: fav)
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 4),
          child: Text(context.read<UserProvider>().getName(),
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
        Text('${context.read<UserProvider>().getLocation()}, Pakistan',
            style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class ButtonMenu extends StatelessWidget {
  ButtonMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttons(
            name: 'My orders',
            icon: 'assets/Order.png',
            width: 100,
            height: 65,
            istable: false,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: buttons(
              name: 'Reservations',
              icon: 'assets/Table.png',
              width: 100,
              height: 60,
              istable: true,
            ),
          )
        ],
      ),
    );
  }
}

class buttons extends StatelessWidget {
  bool istable;
  String icon;
  double width;
  double height;
  String name;

  buttons(
      {Key? key,
      required this.name,
      required this.icon,
      required this.width,
      required this.height,
      required this.istable})
      : super(key: key);

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: Color(0xFF5ABFA3),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 100,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              if (istable) {
                context.read<UserProvider>().getRequests('pending');
                return UserTableReservations();
              }
              return MyOrders();
            }),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset(icon, width: width, height: height),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 12, color: Color(0xFFf2f2f2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavListView extends StatelessWidget {
  List<RestaurantWidget> favourites;

  FavListView({Key? key, required this.favourites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Favourites',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    // color: Color(0xFF5ABFA3),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Favorites(
                                favorites: favourites,
                              )));
                    },
                    child: Text(
                      'view all',
                      style: TextStyle(color: Color(0xFF5ABFA3), fontSize: 12),
                    ))
              ],
            ),
          ),
          Container(
          width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return favourites[index];
                }),
          ),
        ],
      ),
    );
  }
}
