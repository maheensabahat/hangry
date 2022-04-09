import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: null,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(Icons.arrow_back),
      foregroundColor: Color(0xFFF2F2F2),
      backgroundColor: Color(0xFF5ABFA3),
    );
  }
}
