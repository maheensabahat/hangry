import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  List cat1 = ['Italian 1', 'Italian 2', 'Italian 3', 'Italian 4', 'Italian 5'];
  List cat2 = ['Desi 1', 'Desi 2', 'Desi 3', 'Desi 4', 'Desi 5', 'Desi 6'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Color(0xff51bfa3)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
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
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: Text(
                      'Restaurant Name',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'This is the Restaurant\'s Address',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Italian',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: 100,
              itemCount: cat1.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffadd9c9)),
                    height: 100,
                    child: Align(
                      alignment: const Alignment(0, 0),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 100,
                            width: 70,
                            color: const Color(0xff5abfa3),
                          ),
                        ),
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
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Desi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: 100,
              itemCount: cat2.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffadd9c9)),
                    height: 100,
                    child: Align(
                      alignment: const Alignment(0, 0),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            height: 100,
                            width: 70,
                            color: const Color(0xff5abfa3),
                          ),
                        ),
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
          ],
        ),
      ),
    );
  }
}
