import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../User/Widgets/InputBox.dart';

class AdRestaurants extends StatefulWidget {
  const AdRestaurants({Key? key}) : super(key: key);

  @override
  _AdRestaurantsState createState() => _AdRestaurantsState();
}

CollectionReference restaurants =
    FirebaseFirestore.instance.collection('RestaurantEmails');

class _AdRestaurantsState extends State<AdRestaurants> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    InputBox(
                      label: 'Restauarant\'s Email',
                      hintText: '',
                      icon: const Icon(Icons.mail, color: Color(0xFF5ABFA3)),
                      controller: email,
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
                                await restaurants.add({'email': email}).then(
                                  (value) => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Success'),
                                      content: Text(
                                          'Restaurant has been added to the app succesfully, login through the email to complete the details'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Ok'))
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text('Submit'),
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
}
