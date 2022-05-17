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
        (image != null)
            ? Image.network(image,
                width: MediaQuery.of(context).size.width,
                height: 258,
                color: const Color.fromRGBO(255, 255, 255, 0.6),
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.modulate)
            : Image.asset(image,
                width: MediaQuery.of(context).size.width,
                height: 258,
                color: const Color.fromRGBO(255, 255, 255, 0.6),
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.modulate),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 260,
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

        //Rest. Name
        Text(
          Name,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Rest. Cuisine
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            Cuisine,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w600,
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
