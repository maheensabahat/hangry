import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../User/Widgets/InputBox.dart';

class AdAdmins extends StatefulWidget {
  const AdAdmins({Key? key}) : super(key: key);

  @override
  _AdAdminsState createState() => _AdAdminsState();
}
CollectionReference restaurants = FirebaseFirestore.instance.collection('Admin');

class _AdAdminsState extends State<AdAdmins> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //Restaurant data to be showed here
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
                    icon:
                    const Icon(Icons.mail, color: Color(0xFF5ABFA3)),
                    controller: email,
                    isNum: false,
                  ),
              SizedBox(
                height: 40,
                width: 110,
                child: ElevatedButton(
                  onPressed: () async {
                    await restaurants.add({'Email': email}).then((value) => showDialog(
                      context: context, builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Admin has been added to the app succesfully'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))
                      ],
                    ),
                    )
                    );
                  }, child:  Text('Submit'),)
              ),
                ],),
            ),
          ),
        ], ),
    );
  }
}
