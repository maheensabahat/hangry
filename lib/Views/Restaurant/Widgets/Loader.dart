import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          color: Color(0xffadd9c9),
        ),
        height: 50,
        width: 50,
      ),
    );
  }
}
