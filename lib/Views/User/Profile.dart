import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Views/User/MyOrders.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:project/Views/User/Widgets/Restauarant_Widget.dart';
import 'package:provider/provider.dart';
import '../../Providers/UserProvider.dart';
import 'User_TableReservations.dart';
import '../../Entities/Restaurant.dart';
import 'Favorites.dart';
import 'Widgets/Header.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
                  children: [imageProfile(), ProfileDetails()],
                ),
              ),
            ),
            ButtonMenu(),
            FavListView(favourites: fav)
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        // img = context.read<UserProvider>().getImage(),
        _imageFile != null
            ? CircleAvatar(
                radius: 80.0,
                backgroundImage: FileImage(File(_imageFile!.path)))
            : ProfilePicture(),

        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Color(0xFF5ABFA3),
              size: 28.0,
            ),
          ),
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    setState(() {
      _imageFile = pickedFile;
    });
    StoringImage();
  }

  Future<void> StoringImage() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File file = File(_imageFile!.path);

    //Putting the file in firebase storage
    TaskSnapshot taskSnapshot =
        await _storage.ref(_imageFile!.path).putFile(file);
    //downloading URL from firebase storage
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await users
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(doc.id)
            .update({
          "image": downloadUrl,
        }).then(
          (value) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text(
                  'Restaurant has been added to the app successfully'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'))
              ],
            ),
          ),
        );
      }
    });
  }
}

class ProfileDetails extends StatelessWidget {
  ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 4),
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

class ButtonMenu extends StatelessWidget {
  ButtonMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 700),
            child: buttons(
              name: 'My orders',
              icon: 'assets/Order.png',
              width: 100,
              height: 65,
              istable: false,
            ),
          ),
          FadeInRight(
            delay: const Duration(milliseconds: 700),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: buttons(
                name: 'Reservations',
                icon: 'assets/Table.png',
                width: 100,
                height: 60,
                istable: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class buttons extends StatelessWidget {
  bool istable;
  String icon;
  double width;
  double height;
  String name;

  buttons(
      {Key? key,
      required this.name,
      required this.icon,
      required this.width,
      required this.height,
      required this.istable})
      : super(key: key);

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: const Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 100,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              if (istable) {
                context.read<UserProvider>().getRequests('pending');
                return const UserTableReservations();
              }
              return const MyOrders();
            }),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset(icon, width: width, height: height),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  name,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFFf2f2f2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          ],
        ),
      );
    });
  }
}
