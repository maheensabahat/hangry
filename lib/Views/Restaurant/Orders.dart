import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Views/Restaurant/ShowOrders.dart';
import 'package:provider/provider.dart';
import '../../Entities/OrdersHistory.dart';
import '../../Providers/RestaurantProvider.dart';
import 'RestaurantHome.dart';
import 'Widgets/BackButton.dart';
import 'Widgets/Loader.dart';

class Orders2 extends StatefulWidget {
  const Orders2({Key? key}) : super(key: key);

  @override
  _Orders2State createState() => _Orders2State();
}

class _Orders2State extends State<Orders2>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  Widget build(BuildContext context) {
    context.read<RestaurantProvider>().getOrderHistory('pending');
    context.read<RestaurantProvider>().getOrderHistory('approved');
    context.read<RestaurantProvider>().getOrderHistory('rejected');

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
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Orders",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        centerTitle: true,
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          controller: _tabController,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color(0xF05ABFA3),
              Color(0xA05ABFA3),
              Color(0xA05ABFA3),
              Color(0xF05ABFA3),
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: const [
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Approved',
            ),
            Tab(
              text: 'Rejected',
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
              child: RequestList(reqs: provider.Pending_orders),
            )
                : const Loader();
          }),
          Consumer<RestaurantProvider>(builder: (context, provider, child) {
            return Container(
              child: provider.isLoaded
                  ? Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: RequestList(reqs: provider.Approved_orders),
              )
                  : const Loader(),
            );
          }),
          Consumer<RestaurantProvider>(builder: (context, provider, child) {
            return Container(
              child: provider.isLoaded
                  ? Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                child: RequestList(reqs: provider.Rejected_orders),
              )
                  : const Loader(),
            );
          }),
        ],
      ),
    );
  }
}

class RequestList extends StatefulWidget {
  List<OrdersHistory> reqs;

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
                          " Table num " + widget.reqs[index].table_num.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      // leading: Icon(Icons.restaurant),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          formatter.format(widget.reqs[index].date) +
                              "\n" +
                              widget.reqs[index].time,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ShowOrders(
                                type: 'Pending',
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
