import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/Admin/AdMainPage.dart';
import 'package:project/Views/Admin/AdRestaurants.dart';
import 'package:provider/provider.dart';
import '../../Providers/AdminProvider.dart';

class AdRestaurantsDisplay extends StatefulWidget {
  const AdRestaurantsDisplay({Key? key}) : super(key: key);

  @override
  State<AdRestaurantsDisplay> createState() => _AdRestaurantsDisplayState();
}

class _AdRestaurantsDisplayState extends State<AdRestaurantsDisplay> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController cuisineController = TextEditingController();

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
                  MaterialPageRoute(builder: (context) => const AdMainPage()));
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Restaurants',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5abfa3),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdRestaurants(
                      canEdit: false,
                    )),
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
                    itemCount: provider.restaurants.length,
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
                            height: 60,
                            child: Align(
                              alignment: const Alignment(0, 0),
                              child: ListTile(
                                title: Text(
                                  provider.restaurants[index].name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdRestaurants(
                                                canEdit: true,
                                                restaurant:
                                                    provider.restaurants[index],
                                              )),
                                    );
                                  },
                                ),
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
