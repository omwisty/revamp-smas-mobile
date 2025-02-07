import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/attendance/controller/attendance_controller.dart';
import 'package:smartfren_attendance/utils/date/date.dart';
import 'package:smartfren_attendance/widgets/clock_widget.dart';
import 'package:smartfren_attendance/widgets/item_widget.dart';
import 'package:smartfren_attendance/widgets/modal_bottom_widget.dart';

class AttendanceView extends StatelessWidget {
  AttendanceView({Key? key}) : super(key: key);
  AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionChip(
                    avatar: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.location_searching, color: Colors.white, size: 14),
                    ),
                    label: const Text('Refresh Location'),
                    onPressed: controller.refreshLocation
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 5),
                        Text(
                          dateString(),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  ClockWidget(),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Obx(() => controller.isRefreshLocation.value
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black12,
                              child: SpinKitFadingCircle(
                                color: Colors.pinkAccent.shade400,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (!controller.isCheckInLoading.value) {
                                  if(controller.lastStatus.value == "Check In") {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Confirm Check in'),
                                        content: const Text("It seems you have already checked-in, do you want to continue?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'NO'),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'YES');
                                              controller.onPresence(10);
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    controller.onPresence(10);
                                  }
                                }
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.green,
                                child: controller.isCheckInLoading.value
                                  ? const SpinKitFadingCircle(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'IN',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                    ),
                              )
                            )
                          ),
                        Obx(() => controller.isRefreshLocation.value
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black12,
                              child: SpinKitFadingCircle(
                                color: Colors.pinkAccent.shade400,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (!controller.isCheckOutLoading.value) {
                                  if(controller.lastStatus.value == "Check Out") {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Confirm Check out'),
                                        content: const Text("It seems you have already checked-out, do you want to continue?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'NO'),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'YES');
                                              controller.onPresence(20);
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    controller.onPresence(20);
                                  }
                                }
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.red,
                                child: controller.isCheckOutLoading.value
                                  ? const SpinKitFadingCircle(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'OUT',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                              )
                          )
                        )
                      ],
                    ),
                  ),
                  Obx(() => controller.isRefreshLocation.value
                    ? Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: const Text(
                          "Please wait, We still get your current location.",
                          style: TextStyle(fontStyle: FontStyle.italic)
                        ),
                      )
                    : const SizedBox()
                  ),
                  Obx(() => SizedBox(height: controller.isRefreshLocation.value ? 24 : 52)),
                  Column(
                    children: <Widget>[
                      Obx(() => ItemWidget(
                        label: "NIK",
                        value: controller.nik.value,
                        itemType: ItemWidgetType.justify)),
                      Obx(() => ItemWidget(
                        label: "Coordinate (lat)\nCoordinate (long)",
                        value: controller.isRefreshLocation.value ? "Loading..." : "${controller.latitude.value}\n${controller.longitude.value}",
                        itemType: ItemWidgetType.justify)),
                      Obx(() => GestureDetector(
                        onTap: () {
                          ModalBottomWidget(
                            context: context,
                            title: "Address",
                            description: controller.address.value,
                          ).show();
                        },
                        child: ItemWidget(
                          label: "Location",
                          value: controller.isRefreshLocation.value ? "Loading..." : controller.location.value,
                          itemType: ItemWidgetType.justify),
                        )),
                      Obx(() => ItemWidget(
                          label: "Last Status",
                          value: controller.lastStatus.value,
                          itemType: ItemWidgetType.justify)),
                      Obx(() => ItemWidget(
                        label: "Time In\n"
                            "Time Out",
                        value:
                            "${controller.lastPresence.isNotEmpty ? controller.lastPresence['time_in'] : "-"} \n"
                            "${controller.lastPresence.isNotEmpty ? controller.lastPresence['time_out'] : "-"} ",
                        itemType: ItemWidgetType.justify)),
                    ],
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}
