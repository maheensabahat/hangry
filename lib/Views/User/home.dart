import 'package:flutter/material.dart';
import 'package:project/Providers/GoogleSignInProvider.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:project/Views/User/Widgets/Restauarant_Widget.dart';
import 'package:project/main.dart';
import 'package:provider/provider.dart';

import '../../Entities/Category.dart';
import '../../Entities/Restaurant.dart';
import '../../Entities/User.dart';
import '../../Providers/UserProvider.dart';
import 'Qr.dart';
import 'ScanQR.dart';
import 'UserMenu.dart';

class Home extends StatefulWidget {
  Restaurant restaurant = Restaurant(
    name: "Xander's",
    desc:
        "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
    category: 'Cafe',
    isFav: true,
    image: 'assets/restaurant.jpg',
  );
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

  List<RestaurantWidget> restaurants = [
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
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            HomeHeader(
              userName: context.read<UserProvider>().getFirstName(),
            ),

            //Search Bar
            SearchBar(),

            //Categories - heading
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 24),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // color: Color(0xFF5ABFA3),
                ),
              ),
            ),

            //Categories ListView
            CategoriesList(list: Categories),

            //Restaurants
            RestaurantDisplay(restaurants: restaurants)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !widget.user.qr
          ? FloatingActionButton.extended(
              heroTag: null,
              label: Text('Scan QR', style: TextStyle(color: Colors.black)),
              icon: Icon(
                Icons.qr_code,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScanQR(
                          user: widget.user,
                        )));
              },
              backgroundColor: Color(0xff51bfa3),
            )
          : FloatingActionButton.extended(
              heroTag: null,
              label: Text('Menu', style: TextStyle(color: Colors.black)),
              icon: Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserMenu(
                          user: context.read<UserProvider>().getUser(),
                          scanned: context.read<UserProvider>().getQR(),
                          restaurant: widget.restaurant,
                        )));
              },
              backgroundColor: Color(0xff51bfa3),
            ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  String userName;

  HomeHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Hi Jimmy
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 24),
              child: Text('Hi, $userName!',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5ABFA3))),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 30, left: MediaQuery.of(context).size.width * 0.55),
              child: InkWell(
                child: Icon(
                  Icons.logout,
                  color: Color(0xFF5ABFA3),
                ),
                onTap: () {
                  context.read<GoogleSignInProvider>().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: '')),
                  );
                },
              ),
            ),
          ],
        ),

        //Profile pic and Bold Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'What do you\nwant to eat today?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Picture(
                  radius: 40,
                  border: 2,
                  image: context.read<UserProvider>().getImage()),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: TextField(
        controller: search,
        style: const TextStyle(color: Color(0xFF5ABFA3)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 1.0, color: Color(0xFF5ABFA3)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2, color: Color(0xFF5ABFA3))),
          hintText: 'Search here',
          hintStyle: const TextStyle(
              color: Color(0xFFADD9C9),
              fontSize: 12,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Color(0x20ADD9C9),
          suffixIcon: InkWell(
            child: Icon(
              Icons.search,
              color: Color(0xFF5ABFA3),
            ),
          ),
        ),
        cursorColor: Color(0xFF5ABFA3),
      ),
    );
  }
}

class CategoriesList extends StatefulWidget {
  List<Category> list;

  CategoriesList({Key? key, required this.list}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 36),
      child: Container(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          itemBuilder: (context, index) => Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: widget.list[index].isSelected
                  ? Color(0x90F29191)
                  : Color(0x905ABFA3),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              onTap: () {
                widget.list[index].isSelected = !widget.list[index].isSelected;
                setState(() {});
              },
              child: ListTile(
                title: widget.list[index].icon,
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    widget.list[index].label,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantDisplay extends StatelessWidget {
  List<RestaurantWidget> restaurants;

  RestaurantDisplay({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Restuarants',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //List of Restaurants
          RestaurantList(restaurants: restaurants)
        ],
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  List<RestaurantWidget> restaurants;

  RestaurantList({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: restaurants.length,
            itemBuilder: (BuildContext context, int index) {
              // restaurants[index].user = context.read<UserProvider>().getUser();
              return restaurants[index];
            }),
      ),
    );
  }
}
