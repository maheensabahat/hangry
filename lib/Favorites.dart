import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List favorites = [
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
    'Favorite Restaurant',
  ];
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Favorites',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Snap(
        controller: controller.appBar,
        child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          //shrinkWrap: true,
          itemExtent: 100,
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xffadd9c9)),
                height: 100,
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.favorite,
                      color: Color(0xFF154038),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 100,
                        width: 70,
                        color: const Color(0xff5abfa3),
                      ),
                    ),
                    tileColor: const Color(0xffadd9c9),
                    title: Text(
                      favorites[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: const Text('Order ID 12345678',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
