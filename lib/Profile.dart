import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Profile'),

          //Profile Picture
          Text('Full Name'),
          Text('Location'),
          Row(
            //Two Buttons
          ),
          Text('Favourites'),
        ],
      ),
    );
  }
}
