import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'RestaurantHome.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Text(
              'Restaurant Details',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Restaurant Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Owner\'s Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Cuisines Served',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Timings',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.map),
                      fillColor: Color(0x00F2F2F2),
                      hintText: 'Restaurant\'s Location',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: SizedBox(
                    height: 35,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RestaurantHome()),
                        );
                      },
                      child: const Text('Submit'),
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
    );
  }
}
