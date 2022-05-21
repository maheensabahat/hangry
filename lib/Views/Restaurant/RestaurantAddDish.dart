import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Entities/Products.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../User/Widgets/InputBox.dart';
import 'RestaurantMenu.dart';

class RestaurantAddDish extends StatefulWidget {
  bool isEdit;
  Products? product;

  RestaurantAddDish({Key? key, required this.isEdit, this.product})
      : super(key: key);

  @override
  State<RestaurantAddDish> createState() => _RestaurantAddDishState();
}

class _RestaurantAddDishState extends State<RestaurantAddDish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = 'Add Dish';

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      title = 'Edit Dish';
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      descController.text = widget.product!.desc;
      priceController.text = widget.product!.price.toString();
    }
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16),
              //   child: ProfilePicture(),
              // ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: imageProfile(),
                    ),
                    InputBox(
                      label: 'Name',
                      hintText: 'Dish\'s name',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: nameController,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Description',
                      hintText: 'Dish\'s description',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: descController,
                      isNum: false,
                    ),
                    InputBox(
                      label: 'Price',
                      hintText: 'Dish\'s price per unit',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: priceController,
                      isNum: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        height: 40,
                        width: 110,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FirebaseStorage _storage = FirebaseStorage.instance;
                              File file;
                              String downloadUrl = '';
                              if (_imageFile != null) {
                                file = File(_imageFile!.path);
                                //Putting the file in firebase storage
                                TaskSnapshot taskSnapshot = await _storage
                                    .ref(_imageFile!.path)
                                    .putFile(file);
                                //downloading URL from firebase storage
                                downloadUrl =
                                    await taskSnapshot.ref.getDownloadURL();
                              }

                              if (!widget.isEdit) {
                                var item = Products(
                                    name: nameController.text,
                                    price: int.parse(priceController.text),
                                    desc: descController.text,
                                    image:
                                        _imageFile != null ? downloadUrl : null);

                                context
                                    .read<RestaurantProvider>()
                                    .addProduct(item);
                              } else {
                                widget.product!.name = nameController.text;
                                widget.product!.desc = descController.text;
                                widget.product!.price =
                                    int.parse(priceController.text);

                                if (_imageFile != null) {
                                  widget.product!.image = downloadUrl;
                                }

                                context
                                    .read<RestaurantProvider>()
                                    .updateProduct(widget.product!);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RestaurantMenu()),
                              );
                            }
                          },
                          child: widget.isEdit ? Text('Save') : Text('Confirm'),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xff5abfa3)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Center(
        child: Stack(children: <Widget>[
          CircleAvatar(
            radius: 83.0,
            backgroundColor: Color(0xFF5ABFA3),
            child: Padding(
                padding: EdgeInsets.only(top: 1),
                child: _imageFile != null
                    ? CircleAvatar(
                        radius: 80.0,
                        backgroundImage: FileImage(File(_imageFile!.path)))
                    : const CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage("assets/pasta.jpg"))),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFF5ABFA3),
                radius: 22,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color(0xFF5ABFA3),
                    size: 24.0,
                  ),
                ),
              ),
            ),
          )
        ]),
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
