import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  var route;

  Back({Key? key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.chevron_left,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).push(route);
      },
    );
  }
}
