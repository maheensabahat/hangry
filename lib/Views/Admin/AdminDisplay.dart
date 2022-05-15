import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/Admin/AdAdmins.dart';
import 'package:project/Views/Admin/AdMainPage.dart';
import 'package:project/Views/Restaurant/RestaurantAddDish.dart';
import 'package:project/Views/Restaurant/RestaurantHome.dart';
import 'package:provider/provider.dart';

import '../../Providers/AdminProvider.dart';

class AdminDisplay extends StatefulWidget {
  const AdminDisplay({Key? key}) : super(key: key);

  @override
  State<AdminDisplay> createState() => _AdminDisplayState();
}

class _AdminDisplayState extends State<AdminDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdMainPage()));
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Admins',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5abfa3),
        foregroundColor: const Color(0xFF154038),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdAdmins()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 30, 4, 30),
        child: Center(
          child: Consumer<AdminProvider>(builder: (context, provider, child) {
            return (provider.isLoaded)
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemExtent: 100,
                    itemCount: provider.admins.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: FadeInDown(
                          delay: Duration(milliseconds: 800 * (index + 1)),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color(0x405ABFA3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            child: Align(
                              alignment: const Alignment(0, 0),
                              child: ListTile(
                                // leading: Padding(
                                //   padding: const EdgeInsets.all(5),
                                //   child: Container(
                                //     height: 100,
                                //     width: 70,
                                //     color: const Color(0xff5abfa3),
                                //   ),
                                // ),
                                title: Text(
                                  provider.admins[index],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                // subtitle: Text(
                                //     "\$ " +
                                //         provider.productsList[index].price
                                //             .toString(),
                                //     style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                    child: const CircularProgressIndicator(
                      color: Color(0xffadd9c9),
                    ),
                    height: 50,
                    width: 50,
                  ));
          }),
        ),
      ),
    );
  }
}
