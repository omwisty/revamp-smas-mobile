import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/device/controller/device_controller.dart';
import 'package:smartfren_attendance/widgets/item_widget.dart';

class DeviceView extends StatelessWidget {
  DeviceView({Key? key}) : super(key: key);
  DeviceController controller = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Platform.isAndroid
                    ? Image.asset("assets/images/android-logo.png")
                    : Image.asset("assets/images/apple-logo.png"),
                radius: 50,
              ),
            ),
            ItemWidget(
                label: "Platform",
                value: Platform.isAndroid ? "Android" : "iOS",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "Manufacture",
                value: controller.device['manufacture'] ?? "-",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "Model",
                value: controller.device['model'] ?? "-",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "OS Platform",
                value: controller.device['os_platform'] ?? "-",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "OS Version",
                value: controller.device['os_version'] ?? "-",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "App Version",
                value: controller.device['app_version'] ?? "-",
                itemType: ItemWidgetType.justify),
            ItemWidget(
                label: "UUID",
                value: controller.device['uuid'] ?? "-",
                itemType: ItemWidgetType.left),
          ],
        ),
      ),
    );
  }
}
