import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/report/controller/report_controller.dart';
import 'package:smartfren_attendance/utils/date/date.dart';

class ReportListItem extends StatelessWidget {
  ReportListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  ReportController controller = Get.put(ReportController());

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 15.0)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
                  child:  Text(
                    item['address'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
                child: Text(
                  item["presenceFlag"] == 10 ? "IN" : "OUT",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: item["presenceFlag"] == 10 ? Colors.green : Colors.red
                  )
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date : ${dateHumanFormat(DateTime.parse(item["date"].toString()))}",
                style: const TextStyle(fontSize: 14),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Time : ${timeFormat(DateTime.parse(item["presenceDate"].toString()))}",
                style: const TextStyle(fontSize: 14),
              )
            ),
          ),
        ],
      ),
    );
  }
}