import 'package:flutter/material.dart';

class Restaurant extends StatefulWidget {
  String name;
  String desc;
  String category;
  bool isFav;
  String image;

  Restaurant(
      {Key? key,
      required this.name,
      required this.desc,
      required this.category,
      required this.isFav,
      required this.image})
      : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 16),
      width: MediaQuery.of(context).size.width * 0.85,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Color(0xFF5ABFA3)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color:  Color(0xFF5ABFA3).withOpacity(0.2),
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
            child: Image.asset(
              widget.image,
              width: MediaQuery.of(context).size.width * 0.85,
              color: const Color.fromRGBO(255, 255, 255, 0.7),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.fill,
            ),
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
                      Colors.grey.withOpacity(0.0),
                      Colors.black87,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: Color(0xFFADD9C9),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(widget.desc,
                      style: TextStyle(color: Color(0xFFF2F2F2), fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(widget.category,
                      style: TextStyle(
                          color: Color(0xFFADD9C9),
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ),
                if (widget.isFav) ...[
                  Icon(
                    Icons.favorite,
                    size: 40,
                    color: Color(0xFFF29191),
                  )
                ] else ...[
                  Icon(
                    Icons.favorite_border,
                    size: 40,
                    color: Color(0xFFF29191),
                  )
                ],
              ],
            ),
          ),
          Positioned(
            left: 250,
            bottom: 15,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Color(0xFF5ABFA3),
              child: Icon(Icons.arrow_forward_sharp),
            ),
          )
        ],
      ),
    );
  }
}
