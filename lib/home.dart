import 'package:flutter/material.dart';
import 'package:project/Restaurant.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  List<Category> Categories = [
    Category(Icon(Icons.soup_kitchen), 'Chinese'),
    Category(Icon(Icons.fastfood), 'Fast food'),
    Category(Icon(Icons.local_cafe_sharp), 'Cafe'),
    Category(Icon(Icons.dinner_dining), 'Italian'),
  ];

  List<Restaurant> restaurants = [
    Restaurant(
        name: "Xander's",
        desc:
            "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
        category: 'Cafe',
        isFav: false,
        image: 'assets/restaurant.jpg'),
    Restaurant(
        name: "Xander's",
        desc:
            "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
        category: 'Cafe',
        isFav: false,
        image: 'assets/restaurant.jpg'),
    Restaurant(
        name: "Xander's",
        desc:
            "Xander’s is a modern gourmet café – the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
        category: 'Cafe',
        isFav: false,
        image: 'assets/restaurant.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Hi Jimmy
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 24),
              child: Text('Hi, Jimmy!',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5ABFA3))),
            ),

            //Profile pic and Bold Text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'What do you\nwant to eat today?',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color(0xFF5ABFA3),
                  radius: 42,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),

            //Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: TextField(
                controller: search,
                style: const TextStyle(color: Color(0xFF5ABFA3)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(width: 1.0, color: Color(0xFF5ABFA3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFF5ABFA3))),
                  hintText: 'Search here',
                  hintStyle: const TextStyle(
                      color: Color(0xFFADD9C9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: Color(0x20ADD9C9),
                  suffixIcon: InkWell(
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF5ABFA3),
                    ),
                  ),
                ),
                cursorColor: Color(0xFF5ABFA3),
              ),
            ),

            //Categories
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  // color: Color(0xFF5ABFA3),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 10, bottom: 36),
              child: Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Categories.length,
                  itemBuilder: (context, index) => Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0x905ABFA3),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListTile(
                      title: Categories[index].icon,
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          Categories[index].label,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Restuarants',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF5ABFA3),
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: restaurants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return restaurants[index];
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Category {
  Icon icon;
  String label;

  Category(this.icon, this.label);
}
