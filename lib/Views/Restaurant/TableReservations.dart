import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Views/Restaurant/ReservationRequests.dart';
import 'package:provider/provider.dart';
import '../../Entities/ReservationRequest.dart';
import '../../Providers/RestaurantProvider.dart';
import 'ReservationRequests.dart';
import 'RestaurantHome.dart';
import 'Widgets/BackButton.dart';
import 'Widgets/Loader.dart';

class TableReservations extends StatefulWidget {
  const TableReservations({Key? key}) : super(key: key);

  @override
  _TableReservationsState createState() => _TableReservationsState();
}

class _TableReservationsState extends State<TableReservations>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  Widget build(BuildContext context) {
    context.read<RestaurantProvider>().getRequests('pending');
    context.read<RestaurantProvider>().getRequests('approved');

    return Scaffold(
      appBar: AppBar(
        leading: Back(
          route: MaterialPageRoute(builder: (context) => RestaurantHome()),
        ),
        toolbarHeight: 150,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              context.read<RestaurantProvider>().restaurant.name,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Table Reservations",
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
          ),
          tabs: [
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Approved',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<RestaurantProvider>(builder: (context, provider, child) {
            return provider.isLoaded
                ? Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 20),
                    child: RequestList(reqs: provider.Pending_request),
                  )
                : Loader();
          }),
          Consumer<RestaurantProvider>(builder: (context, provider, child) {
            return Container(
              child: provider.isLoaded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 20),
                      child: RequestList(reqs: provider.Approved_request),
                    )
                  : Loader(),
            );
          }),
        ],
      ),
    );
  }
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
              delay: Duration(milliseconds: 500 * (index + 1)),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0x405ABFA3),
                    borderRadius: BorderRadius.circular(10)),
                height: 80,
                child: Align(
                  alignment: const Alignment(0, 0),
                  child: InkWell(
                    child: ListTile(
                      title: Text(
                          " Table for " + widget.reqs[index].seats.toString(),
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReservationRequests(
                                    type: 'pending',
                                    request: widget.reqs[index],
                                  )));
                        },
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
