import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../User/Widgets/InputBox.dart';
import 'package:image_picker/image_picker.dart';
class AdRestaurants extends StatefulWidget {
  const AdRestaurants({Key? key}) : super(key: key);

  @override
  _AdRestaurantsState createState() => _AdRestaurantsState();
}

CollectionReference restaurants =
    FirebaseFirestore.instance.collection('Restaurants');

class _AdRestaurantsState extends State<AdRestaurants> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cuisine = TextEditingController();
  TextEditingController desc = TextEditingController();

  final _formKey = GlobalKey<FormState>();
   XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/Table.png',
                height: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 70),
              child: Text(
                'Enter Restaurant to the \n Database:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageProfile(),
                    InputBox(
                      label: 'Restauarant\'s Email',
                      hintText: '',
                      icon: const Icon(Icons.mail, color: Color(0xFF5ABFA3)),
                      controller: email,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Restauarant\'s Name',
                      hintText: '',
                      icon:
                      const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: name,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Cuisine',
                      hintText: '',
                      icon: const Icon(Icons.dinner_dining,
                          color: Color(0xFF5ABFA3)),
                      controller: cuisine,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Description about the Restaurant',
                      hintText: '',
                      icon: const Icon(Icons.description,
                          color: Color(0xFF5ABFA3)),
                      controller: desc,
                      isNum: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          height: 40,
                          width: 110,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await restaurants.add({'email': email.text, 'name': name.text,
                                'cuisine':cuisine.text, 'desc': desc.text, 'image': _imageFile!.path}).then(
                                  (value) => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Success'),
                                      content: const Text(
                                          'Restaurant has been added to the app succesfully'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Ok'))
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text('Submit'),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Color(0xFF154038),
                                primary: const Color(0xff5abfa3)),
                          )),
                    ),
                  ],
                ),
              ),
            ),
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
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
  Widget imageProfile(){
    return Center(
      child: Stack(
          children: <Widget> [
            _imageFile != null
      ? CircleAvatar(
                radius: 80.0,
                backgroundImage: FileImage(File(_imageFile!.path))
            )
            : CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage("assets/profile.jpeg")
            ),

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
          ]
      ),
    );
  }
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

}





