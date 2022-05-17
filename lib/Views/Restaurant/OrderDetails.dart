import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Entities/OrdersHistory.dart';
import '../User/Widgets/InputBox.dart';


class OrderDetails extends StatelessWidget {
  OrdersHistory request;
  bool isUser;

  OrderDetails({Key? key, required this.request, required this.isUser})
      : super(key: key);

  var formatter = DateFormat('EE dd-MMM-yy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          label: 'Table Num',
          hintText: '',
          icon: const Icon(Icons.chair,
              color: Color(0xFF5ABFA3)),
          controller: TextEditingController(
              text: request.table_num),
          isNum: false,
          canEdit: false,
        ),
             InputBox(
          label: 'User id',
          hintText: '',
          icon: const Icon(Icons.people, color: Color(0xFF5ABFA3)),
          controller:
          TextEditingController(text: request.user_id),
          isNum: false,
          canEdit: false,
        ),
        InputBox(
          label: 'Date',
          hintText: '',
          icon: const Icon(Icons.calendar_today, color: Color(0xFF5ABFA3)),
          controller:
          TextEditingController(text: formatter.format(request.date)),
          isNum: false,
          canEdit: false,
        ),
        ListView.builder(
            itemExtent: 50,
            itemCount: request.product_details.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: FadeInDown(
                  delay: Duration(milliseconds: 500 * (index + 1)),
                     child: Container(
                        decoration: BoxDecoration(
                        color: const Color(0x405ABFA3),
                        borderRadius: BorderRadius.circular(10)),
                        height: 80,
                        child: Align(
                          alignment: const Alignment(0, 0),
                          child: InkWell(
                          child: ListTile(
                            title: Text(request.product_details[index].name,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            subtitle: Padding(
                            padding: const EdgeInsets.all(4.0),
                             child: Text(" Price is " + request.product_details[index].price + "    Quantity " +request.product_details[index].quantity,
                              style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            //Trailing pic can be inserted here of product
                          ),
                          ),
                      ),
                  ),
              ));
        }
        ),
      ],
    );
  }
}

