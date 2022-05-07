import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:provider/provider.dart';
import '../../Entities/Restaurant.dart';
import '../User/Widgets/InputBox.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController cuisine = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
        builder: (context, restProvider, child) {
      Restaurant r = restProvider.restaurant;

      name.text = r.name;
      cuisine.text = r.category;
      desc.text = r.desc;

      return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/Table.png',
                height: 150,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Text(
                  'Restaurant Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputBox(
                        label: 'Restauarant\'s Name',
                        hintText: '',
                        icon:
                            const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                        controller: name,
                        isNum: false,
                      ),
                      InputBox(
                        label: 'Cuisine',
                        hintText: '',
                        icon: const Icon(Icons.dinner_dining,
                            color: Color(0xFF5ABFA3)),
                        controller: cuisine,
                        isNum: false,
                      ),
                      InputBox(
                        label: 'Description about the Restaurant',
                        hintText: '',
                        icon: const Icon(Icons.description,
                            color: Color(0xFF5ABFA3)),
                        controller: desc,
                        isNum: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: restProvider.isLoaded
                            ? SizedBox(
                                height: 40,
                                width: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    r.name = name.text;
                                    r.category = cuisine.text;
                                    r.desc = desc.text;

                                    context
                                        .read<RestaurantProvider>()
                                        .updateDetails(r);
                                  },
                                  child: const Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.black,
                                      primary: const Color(0xff5abfa3)),
                                ))
                            : CircularProgressIndicator(
                                color: Color(0xff5abfa3),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
