import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:provider/provider.dart';

import '../../../Entities/User.dart';
import '../../../Providers/UserProvider.dart';
import '../UserMenu.dart';

class RestaurantWidget extends StatefulWidget {
  Restaurant restaurant;

  RestaurantWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    bool? isfav = widget.restaurant.isFav;

    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 16),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 170,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Color(0xFF5ABFA3)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5ABFA3).withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: widget.restaurant.image == null
                ? Image.asset(
                    widget.restaurant.image,
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    colorBlendMode: BlendMode.modulate,
                    fit: BoxFit.cover,
                  )
                : Image.network(widget.restaurant.image,
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: const Color.fromRGBO(255, 255, 255, 0.7),
                    colorBlendMode: BlendMode.modulate,
                    fit: BoxFit.fill),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 180,
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(9)),
                gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      Colors.black87.withOpacity(0.5),
                      Colors.grey.withOpacity(0.0),
                      Colors.black54,
                      Colors.black87,
                    ],
                    stops: [
                      1.0,
                      0.0,
                      0.5,
                      1.0
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 18, 20, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                      color: Color(0xFFADD9C9),
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(widget.restaurant.desc,
                      style: const TextStyle(
                          color: Color(0xFFF2F2F2), fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(widget.restaurant.category,
                      style: const TextStyle(
                          color: Color(0xFFADD9C9),
                          fontSize: 14,
                          fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ),
          if (isfav != null) ...[
            Positioned(
              bottom: 20,
              left: 185,
              child: InkWell(
                onTap: () {
                  debugPrint(widget.restaurant.isFav.toString());
                  if (!(widget.restaurant.isFav!)) {
                    setState(() {
                      context.read<UserProvider>().MarkFav(widget.restaurant);
                    });
                  } else {
                    setState(() {
                      context.read<UserProvider>().removeFav(widget.restaurant);
                    });
                  }
                },
                child: Icon(
                  isfav ? Icons.favorite : Icons.favorite_border,
                  size: 40,
                  color: Color(0xffF29191),
                ),
              ),
            ),
          ],
          Positioned(
            left: 230,
            bottom: 15,
            child: FloatingActionButton.small(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserMenu(
                          user: context.read<UserProvider>().getUser(),
                          scanned: false,
                          restaurant: widget.restaurant,
                        )));
              },
              backgroundColor: Color(0xFF5ABFA3),
              foregroundColor: Color(0xFFF2F2F2),
              child: const Icon(Icons.arrow_forward_sharp),
            ),
          )
        ],
      ),
    );
  }
}
