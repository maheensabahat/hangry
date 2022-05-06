import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Views/Restaurant/ReservationRequests.dart';
import 'package:provider/provider.dart';

import '../../Entities/ReservationRequest.dart';
import '../../Providers/UserProvider.dart';

class UserTableReservations extends StatefulWidget {
  const UserTableReservations({Key? key}) : super(key: key);

  @override
  _UserTableReservationsState createState() => _UserTableReservationsState();
}

class _UserTableReservationsState extends State<UserTableReservations>
    with SingleTickerProviderStateMixin {
  @override
  late final _tabController = TabController(length: 2, vsync: this);

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                "Reservation History",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Reservation requests status",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 24),
            controller: _tabController,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xF05ABFA3),
                  Color(0xA05ABFA3),
                  Color(0xA05ABFA3),
                  Color(0xF05ABFA3),
                ]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent),
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                    List<ReservationRequest> reqs =
                        userProvider.user.Pending_Reservations;
                    return (userProvider.reqsLoaded)
                        ? RequestList(reqs: reqs)
                        : Center(
                            child: Container(
                            child: CircularProgressIndicator(
                              color: Color(0xffadd9c9),
                            ),
                            height: 50,
                            width: 50,
                          ));
                  })),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Container(
                child: Text('Approved'),
                // child: RequestList(status: 'approved'),
              ),
            ),
          ],
        ),
      );
}

class RequestList extends StatefulWidget {
  List<ReservationRequest> reqs;

  RequestList({Key? key, required this.reqs}) : super(key: key);

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  var formatter = DateFormat('E dd-MMM-yy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 100,
      itemCount: widget.reqs.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: FadeInDown(
              delay: Duration(milliseconds: 800 * (index + 1)),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0x405ABFA3),
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: InkWell(
                    child: ListTile(
                      title: Text("Restaurant's Name",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      // leading: Icon(Icons.restaurant),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          formatter.format(widget.reqs[index].date) +
                              "\n" +
                              widget.reqs[index].time,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
