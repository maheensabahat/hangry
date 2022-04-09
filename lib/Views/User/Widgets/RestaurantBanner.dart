import 'package:flutter/material.dart';

class RestaurantBanner extends StatelessWidget {
  String Name;
  String Cuisine;
  String image;

  RestaurantBanner(
      {Key? key,
      required this.Name,
      required this.Cuisine,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //Image
        Image.asset(image,
            width: MediaQuery.of(context).size.width,
            height: 258,
            color: const Color.fromRGBO(255, 255, 255, 0.6),
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.modulate),

        //Rest. Name
        Text(
          Name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Rest. Cuisine
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Text(
            Cuisine,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        //Bottom Highlight
        Padding(
          padding: const EdgeInsets.only(top: 240),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border:
                  Border(top: BorderSide(width: 2, color: Color(0xFF5ABFA3))),
            ),
            child: Text(''),
          ),
        ),
      ],
    );
  }
}
