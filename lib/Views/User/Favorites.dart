import 'package:flutter/material.dart';
import 'package:project/Views/User/Widgets/Restauarant_Widget.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Favorites extends StatefulWidget {
  List<RestaurantWidget> favorites;

  Favorites({Key? key, required this.favorites}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Favorites',
            style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),

      //List of favs
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: ListView.builder(
                itemExtent: 100,
                itemCount: widget.favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0x905ABFA3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 100,
                      child: Align(
                        alignment: const Alignment(0, 0),
                        //Each fav
                        child: ListTile(
                          trailing: const Icon(
                            Icons.favorite,
                            color: Color(0xFFF29191),
                          ),

                          //Image
                          leading: Container(
                            height: 100,
                            width: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/restaurant.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),

                          //Rest. Name
                          title: Text(
                            widget.favorites[index].restaurant.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          //Rest. Category
                          subtitle: Text(
                              'Category: ' +
                                  widget.favorites[index].restaurant.category,
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
