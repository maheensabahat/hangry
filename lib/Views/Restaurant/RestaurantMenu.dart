import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/Restaurant/RestaurantAddDish.dart';
import 'package:project/Views/Restaurant/RestaurantHome.dart';
import 'package:provider/provider.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({Key? key}) : super(key: key);

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
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
                  MaterialPageRoute(builder: (context) => RestaurantHome()));
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5abfa3),
        foregroundColor: Color(0xFF154038),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantAddDish(
                      isEdit: false,
                    )),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 30, 4, 30),
        child: Center(
          child:
              Consumer<RestaurantProvider>(builder: (context, provider, child) {
            var items = provider.restaurant.items;
            return (provider.isLoaded)
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemExtent: 100,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: FadeInDown(
                          delay: Duration(milliseconds: 800 * (index + 1)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x405ABFA3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            child: Align(
                              alignment: const Alignment(0, 0),
                              child: ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantAddDish(
                                                isEdit: true,
                                                product: items[index],
                                              )),
                                    );
                                  },
                                ),
                                // leading: Padding(
                                //   padding: const EdgeInsets.all(5),
                                //   child: Container(
                                //     height: 100,
                                //     width: 70,
                                //     color: const Color(0xff5abfa3),
                                //   ),
                                // ),
                                title: Text(
                                  items[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                    "\$ " + items[index].price.toString(),
                                    style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Container(
                    child: CircularProgressIndicator(
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
