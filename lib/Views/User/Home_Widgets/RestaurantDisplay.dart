import 'package:flutter/material.dart';

import '../../../Entities/Restaurant.dart';
import '../Widgets/Restauarant_Widget.dart';

class RestaurantDisplay extends StatelessWidget {
  List<Restaurant> restaurants;

  RestaurantDisplay({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
          const Padding(
            padding: const EdgeInsets.only(bottom: 8),
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
  List<Restaurant> restaurants;

  RestaurantList({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.33,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: restaurants.length,
            itemBuilder: (BuildContext context, int index) {
              return RestaurantWidget(restaurant: restaurants[index]);
            }),
      ),
    );
  }
}
