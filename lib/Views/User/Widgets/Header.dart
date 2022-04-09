import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String title;
  double bottom;

  Header({Key? key, required this.title, required this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70, bottom: bottom),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
