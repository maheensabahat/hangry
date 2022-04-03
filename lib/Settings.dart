import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  int i = 3;
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 40),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          width: 220,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xFF154038),
                primary: Color(0xFF5ABFA3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
            // Navigator.of(context).push(widget.next_page);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text('Edit your Profile'),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          width: 220,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xFF154038),
                primary: Color(0xFF5ABFA3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              // Navigator.of(context).push(widget.next_page);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text('About Hangry'),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          width: 220,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xFF154038),
                primary: Color(0xFF5ABFA3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              // Navigator.of(context).push(widget.next_page);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.help_outline_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text('Help'),
                ),
              ],
            ),
          ),
        ),

      ],
    ));
  }
}
