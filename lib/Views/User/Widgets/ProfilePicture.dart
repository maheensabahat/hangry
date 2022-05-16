import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/UserProvider.dart';

class Picture extends StatelessWidget {
  double radius;
  double border;
  String? image;

  Picture(
      {Key? key,
      required this.radius,
      required this.border,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xFF5ABFA3),
      radius: radius + 4,
      child: CircleAvatar(
        radius: radius,
        // backgroundImage: AssetImage(image),
        backgroundImage: checkImage(image) ? NetworkImage(image!) : null,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  bool checkImage(String? image) {
    return image != null;
  }
}

class ProfilePicture extends StatelessWidget {
  ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Outer Circle
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: const Color(0xFFADD9C9))),
        ),

        //Profile Picture
        Padding(
            padding: const EdgeInsets.only(left: 11, top: 11),
            child: Picture(
              radius: 70,
              border: 4,
              image: context.read<UserProvider>().getImage(),
            )),

        // Edit Button
        // const Padding(
        //   padding: EdgeInsets.only(left: 120, top: 120),
        //   child: CircleAvatar(
        //     radius: 20,
        //     backgroundColor: Color(0xF0ADD9C9),
        //     // child: Icon(Icons.edit, color: Color(0xFF154038)),
        //   ),
        // )
      ],
    );
  }
}
