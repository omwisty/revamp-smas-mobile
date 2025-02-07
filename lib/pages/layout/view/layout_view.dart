import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/attendance/view/attendance_view.dart';
import 'package:smartfren_attendance/pages/device/view/device_view.dart';
import 'package:smartfren_attendance/pages/layout/controller/layout_controller.dart';
import 'package:smartfren_attendance/pages/profile/view/profile_view.dart';
import 'package:smartfren_attendance/pages/report/view/report_view.dart';
import 'package:smartfren_attendance/pages/settings/viiew/settings_view.dart';
import 'package:smartfren_attendance/widgets/appbar_widget.dart';

class LayoutView extends StatelessWidget {
  LayoutView({Key? key}) : super(key: key);
  LayoutController controller = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBarWidget(
            preferredSize: const Size(double.infinity, 50),
            title: controller.title.value),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              ReportView(),
              DeviceView(),
              AttendanceView(),
              SettingsView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            backgroundColor: const Color(0xFFF50057),
            color: Colors.white,
            items: const [
              TabItem(icon: Icons.bar_chart, title: 'Report'),
              TabItem(icon: Icons.phone_iphone, title: 'Device'),
              TabItem(icon: Icons.location_history_outlined, title: 'Attendance'),
              TabItem(icon: Icons.settings, title: 'Settings'),
              TabItem(icon: Icons.people, title: 'Profile'),
            ],
            initialActiveIndex: controller.tabIndex.value,
            onTap: controller.onChangeTabIndex,
          )
        )
      )
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 5;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 12, color: color);
  }
}