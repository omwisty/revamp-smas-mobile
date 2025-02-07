import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/attendance/controller/attendance_controller.dart';

class ClockWidget extends StatelessWidget {
  ClockWidget({Key? key}) : super(key: key);
  AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 0),
          child: Center(
            child: Obx(() => Text(
              controller.clock.value,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            )),
          ),
        ),
      ],
    );
  }

}