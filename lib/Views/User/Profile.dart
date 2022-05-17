import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:provider/provider.dart';
import '../../Providers/UserProvider.dart';
import 'Profile_Widgets/ButtonMenu.dart';
import 'Profile_Widgets/FavListView.dart';
import '../../Entities/Restaurant.dart';
import 'Widgets/Header.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Restaurant> fav = [];
  XFile? _imageFile;

  // XFile? img;
  final ImagePicker _picker = ImagePicker();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  late String email;

  Widget build(BuildContext context) {
    context.read<UserProvider>().getFav();
    fav = context.read<UserProvider>().user.favs;
    email = context.read<UserProvider>().getEmail();
    // img = context.read<UserProvider>().getImage();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Header(
                title: 'Profile',
                bottom: 25,
              ),
            ),
            Center(
              child: FadeInDown(
                delay: const Duration(milliseconds: 900),
                child: Column(
                  children: [ProfilePicture(), ProfileDetails()],
                ),
              ),
            ),
            ButtonMenu(),
            FavListView()
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 4),
          child: Text(context.read<UserProvider>().getName(),
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
        Text('${context.read<UserProvider>().getLocation()}, Pakistan',
            style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
