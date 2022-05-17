import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Providers/AdminProvider.dart';
import 'package:project/Views/Admin/AdminDisplay.dart';
import 'package:provider/provider.dart';
import '../User/Widgets/InputBox.dart';

class AdAdmins extends StatefulWidget {
  const AdAdmins({Key? key}) : super(key: key);

  @override
  _AdAdminsState createState() => _AdAdminsState();
}

CollectionReference restaurants =
    FirebaseFirestore.instance.collection('Admin');

class _AdAdminsState extends State<AdAdmins> {
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
                'assets/adAdmin.png',
                height: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 70),
              child: Text(
                'Enter Admin to the \n Database:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputBox(
                      label: 'Admin\'s Email',
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
                              await restaurants
                                  .add({'Email': email.text.trim()}).then((value) {
                                Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .getAdmins();
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Success'),
                                    content: const Text(
                                        'Admin has been added to the app succesfully'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminDisplay()));
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ),
                                );
                              });
                            }
                          },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color(0xFF154038),
                              primary: const Color(0xff5abfa3)),
                        ),
                      ),
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
