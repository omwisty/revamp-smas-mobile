import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:smartfren_attendance/pages/report/controller/report_controller.dart';
import 'package:smartfren_attendance/pages/report/view/report_list_item.dart';
import 'package:smartfren_attendance/utils/date/date.dart';
import 'package:smartfren_attendance/widgets/appbar_widget.dart';
import 'package:smartfren_attendance/widgets/empty_data_widget.dart';

class ReportListView extends StatelessWidget {
  ReportListView({Key? key}) : super(key: key);
  ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(preferredSize: Size(double.infinity, 50), title: "SMAS Log History", haveBack: true),
      body: SafeArea(
        child: controller.filter.isNotEmpty
          ? GroupedListView<dynamic, String>(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              elements: controller.filter,
              groupBy: (element) => element['date'],
              order: GroupedListOrder.DESC,
              groupSeparatorBuilder: (value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  avatar: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.calendar_today, size: 12, color: Colors.black),
                  ),
                  label: Text(dateHumanFormat(DateTime.parse(value.toString()))),
                ),
              ),
              itemBuilder: (c, element) {
                return ReportListItem(item: element);
              },
              useStickyGroupSeparators: true,
              floatingHeader: true,
            )
          : const EmptyDataWidget(content: "Report Attendance Not Found"),
      ),
    );
  }

}