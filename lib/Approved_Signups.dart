import 'package:flutter/material.dart';
import 'package:project/Table_reservation.dart';

class Approved_Signups extends StatefulWidget {
  const Approved_Signups({Key? key}) : super(key: key);

  @override
  _Approved_SignupsState createState() => _Approved_SignupsState();
}

class _Approved_SignupsState extends State<Approved_Signups> {
  @override

  List<Signups> Pending_signups = [
    Signups(name: "O Donuts"),
    Signups(name: "Moos n Clucks"),
    Signups(name: "Fibbi Cafe"),
    Signups(name: "KFC"),
    Signups(name: "Cafe Praha"),
    Signups(name: "Cafe Picante"),
    Signups(name: "CFU"),
    Signups(name: "Vegas"),
  ];

  List<Signups> Approved_signups = [
    Signups(name: "Mcdonalds"),
    Signups(name: "Cafe two or more"),
    Signups(name: "Ziist"),
    Signups(name: "Big C restaurant"),
    Signups(name: "Cafe Aylanto"),
    Signups(name: "Burger o clock"),
    Signups(name: "Kababjees Express"),
    Signups(name: "De Valley"),
    Signups(name: "Xander\'s"),
    Signups(name: "Sizzlers"),
    Signups(name: "Del Frio"),
  ];

  List<Signups> Rejected_signups = [
    Signups(name: "Boxd"),
    Signups(name: "Big Bash"),
    Signups(name: "Burger Lab"),
    Signups(name: "2 guys bistro"),
    Signups(name: "Thirsty"),
  ];

  Widget build(BuildContext context) {
    return Column(children: [
      Text('checking column',style: TextStyle(fontSize: 30),),
    Expanded(
      child: DefaultTabController(length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Signups'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Pending Signups',
                  ),
                  Tab(
                    text: 'Approved Signups',
                  ),
                  Tab(
                    text: 'Rejected Signups',
                  ),
                ],
              ),
            ),
            body: TabBarView(
                children: [
                  MaterialApp(home: Center(child: list(Pending_signups) ,),),

                  MaterialApp(home: Center(child: list(Approved_signups) ,),),

                  MaterialApp(home: Center(child: list(Rejected_signups) ,),),
                ],
            ),

      ),),
    ),
    ]
    );
  }
}

class Signups{
  final String name;

  Signups({required this.name});
}

ListView list(List x) {
     return ListView.builder(
      itemCount: x.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(x[index].name),
            leading: Icon(Icons.restaurant),
            trailing: ElevatedButton(
              child: Icon(Icons.arrow_right),
              onPressed: () {},
            ));
      },
    );
}
