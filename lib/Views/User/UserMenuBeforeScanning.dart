import 'package:flutter/material.dart';
import 'package:project/Views/User/ReserveTable.dart';

import 'ScanQR.dart';
import 'Widgets/RestaurantBanner.dart';

class UserMenuBeforeScanning extends StatefulWidget {
  const UserMenuBeforeScanning({Key? key}) : super(key: key);

  @override
  State<UserMenuBeforeScanning> createState() => _UserMenuBeforeScanningState();
}

class _UserMenuBeforeScanningState extends State<UserMenuBeforeScanning> {
  List cat1 = ['Italian 1', 'Italian 2', 'Italian 3', 'Italian 4', 'Italian 5'];
  List cat2 = ['Desi 1', 'Desi 2', 'Desi 3', 'Desi 4', 'Desi 5', 'Desi 6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image Banner
                RestaurantBanner(
                    Name: "Restaurant's Name",
                    Cuisine: 'Cuisine',
                    image: 'assets/restaurant.jpg'),

                //Categories
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
                  child: Text(
                    'Italian',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                //List for each Category
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 100,
                  itemCount: cat1.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 5, 25, 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffadd9c9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 100,
                        child: Align(
                          alignment: const Alignment(0, 0),
                          child: ListTile(
                            leading: Container(
                                height: 100,
                                width: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/pasta.jpg',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            tileColor: const Color(0xffadd9c9),
                            title: Text(
                              cat1[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: const Text('This is a dish',
                                style: TextStyle(color: Colors.black)),
                            trailing: const Text('Rs. 1000'),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //Second Category
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
                  child: Text(
                    'Desi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                //List of items for second Category
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemExtent: 100,
                    itemCount: cat2.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(24, 5, 25, 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffadd9c9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 100,
                          child: Align(
                            alignment: const Alignment(0, 0),
                            child: ListTile(
                              leading: Container(
                                  height: 100,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/pasta.jpg',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              tileColor: const Color(0xffadd9c9),
                              title: Text(
                                cat2[index],
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: const Text('This is a dish',
                                  style: TextStyle(color: Colors.black)),
                              trailing: const Text('Rs. 1000'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            //
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Color(0xff51bfa3),
                      child: Icon(Icons.table_restaurant),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ReserveTable()));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.qr_code),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ScanQR()));
                      },
                      backgroundColor: Color(0xff51bfa3),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),

        //Back
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: BackButton());
  }
}
