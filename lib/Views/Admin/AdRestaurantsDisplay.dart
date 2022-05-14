import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/Admin/AdMainPage.dart';
import 'package:project/Views/Admin/AdRestaurants.dart';
import 'package:provider/provider.dart';
import '../../Entities/Restaurant.dart';
import '../../Providers/AdminProvider.dart';

class AdRestaurantsDisplay extends StatefulWidget {
  const AdRestaurantsDisplay({Key? key}) : super(key: key);

  @override
  State<AdRestaurantsDisplay> createState() => _AdRestaurantsDisplayState();
}

class _AdRestaurantsDisplayState extends State<AdRestaurantsDisplay> {

  _builTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xff5abfa3),
        border: Border.all(color: const Color(0xFF154038)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),

      ),
    );
  }

  //  rest(required String email, String name, String cuisine, String desc, String image ) {
  //   this.email = email;
  //   this.name = name;
  //   this.cuisine = cuisine;
  //   this.email = desc;
  //   this.email = image;
  //
  //   return rest;
  // }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController cuisineController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // CollectionReference ref = FirebaseFirestore.instance.collection('Restaurants');
  // QuerySnapshot snapshot = await firestore.collection("users");


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
              Navigator.of(context)
                  .push(
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
        foregroundColor: const Color(0xFF154038),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdRestaurants()),
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
                      height: 100,
                      child: Align(
                        alignment: const Alignment(0, 0),
                        child: ListTile(
                          title: Text(
                            provider.restaurants[index],
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              nameController =
                              provider.restaurants[index].doc['name'];
                              descController =
                              provider.restaurants[index].doc['phone'];
                              cuisineController =
                              provider.restaurants[index].doc['location'];
                              imageController =
                              provider.restaurants[index].doc['image'];

                              showDialog(context: context, builder: (context) =>
                                  Dialog(
                                    child: Container(
                                      color: const Color(0xff5abfa3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            _builTextField(
                                                nameController, 'Name'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            _builTextField(
                                                descController, 'Phone'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            _builTextField(
                                                cuisineController, 'Location'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            _builTextField(
                                                imageController, 'Image Url'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FlatButton(
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                    'Update Restaurant Details'),
                                              ),
                                              color: Colors.green,
                                              onPressed: () {
                                                context.read<AdminProvider>()
                                                    .updateRest(email: provider
                                                    .restaurants[index]
                                                    .doc['email'],
                                                    name: nameController,
                                                    cuisine: cuisineController,
                                                    imageUrl: imageController,
                                                    desc: descController);

                                                setState(() {});


                                                //
                                                // await provider.updateRestDetails({'email': emailController.text, 'name': nameController.text,
                                                //   'cuisine':cuisineController.text, 'desc': descController.text, 'image': imageController})
                                                //     .then(
                                                //       (value) => showDialog(
                                                //     context: context,
                                                //     builder: (context) => AlertDialog(
                                                //       title: const Text('Success'),
                                                //       content: const Text(
                                                //           'Restaurant has been updated successfully'),
                                                //       actions: [
                                                //         TextButton(
                                                //             onPressed: () =>
                                                //                 Navigator.pop(context),
                                                //             child: const Text('Ok'))
                                                //       ],
                                                //     ),
                                                //   ),
                                                // );

                                              },),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FlatButton(
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                    'Delete Restaurant'),
                                              ),
                                              color: Colors.red,
                                              onPressed: () {
                                                //delete function here


                                              },),

                                          ],

                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),

                          // trailing: IconButton(
                          //   icon: const Icon(Icons.delete),
                          //   onPressed: (){
                          //     final deleteR = FirebaseFirestore.instance.collection('Restaurants')
                          //                      .doc(provider.restaurants[index]);
                          //     deleteR.delete().then((value) =>
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) => AlertDialog(
                          //         title: const Text('Success'),
                          //         content: const Text(
                          //             'Restaurant has been deleted from the app successfully'),
                          //         actions: [
                          //           TextButton(
                          //               onPressed: () =>
                          //                   Navigator.pop(context),
                          //               child: Text('Ok'))
                          //         ],
                          //       ),
                          //     ),
                          //     );
                          // },),
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


//   Restaurant r(
//       {required String email, required String name, required String cuisine, required String desc}) {
//     this.email = email;
//     this.name = name;
//     this.cuisine = cuisine;
//     this.desc = desc;
//   }
//
//