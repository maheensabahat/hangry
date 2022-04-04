import 'package:flutter/material.dart';

class ReserveTable extends StatefulWidget {
  const ReserveTable({Key? key}) : super(key: key);

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [

              Image.asset('assets/restaurant.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  colorBlendMode: BlendMode.modulate
                ),

              const Text(
                "Restaurant's Name",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Cuisine',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                   child: Text(''),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
