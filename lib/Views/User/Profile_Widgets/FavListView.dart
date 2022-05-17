import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Entities/Restaurant.dart';
import '../../../Providers/UserProvider.dart';
import '../Favorites.dart';
import '../Widgets/Restauarant_Widget.dart';

class FavListView extends StatelessWidget {
  FavListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getFav();
    return Consumer<UserProvider>(builder: (context, provider, child) {
      List<Restaurant> favs = provider.user.favs;
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
                  FadeInLeft(
                    delay: Duration(milliseconds: 900),
                    child: Text(
                      'Your Favourites',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF5ABFA3),
                      ),
                    ),
                  ),
                  FadeInUp(
                    delay: Duration(milliseconds: 800),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Favorites(
                                favorites: favs,
                              )));
                        },
                        child: Text(
                          'view all',
                          style:
                          TextStyle(color: Color(0xFF5ABFA3), fontSize: 12),
                        )),
                  )
                ],
              ),
            ),
            FadeInUp(
              delay: Duration(milliseconds: 900),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: favs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: RestaurantWidget(restaurant: favs[index]));
                      }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
