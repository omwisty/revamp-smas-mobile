import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/app_config.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';
import 'package:smartfren_attendance/pages/login/controller/login_controller.dart';
import 'package:smartfren_attendance/pages/login/view/login_form.dart';
import 'package:smartfren_attendance/widgets/item_widget.dart';
import 'package:smartfren_attendance/widgets/modal_bottom_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final flavour = AppConfig.env;
  var controller = Get.put(LoginController());
  var initController = Get.put(InitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Image.asset("assets/images/red-header.png"),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 35.0, right: 35.0, top: 0.0, bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Image.asset("assets/images/logo-master.png",
                          width: 200),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    const LoginForm(),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/change-uuid');
                      },
                      child: const Text(
                        "Change UUID",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Obx(() => Text("Version ${controller.version.value}")),
                    flavour.getEnvironmentName() != "Production" ? Text("Environment ${flavour.getEnvironmentName()}") : const SizedBox(),
                  ],
                ),
              ),
            )
          ],
        )
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
        onPressed: () {
          ModalBottomWidget(
            context: context,
            title: "Device Information",
            description: "Your device need to be registrated in order to use this application",
            content: [
              ItemWidget(
                label: "Manufacture",
                value: controller.device['manufacture'],
                itemType: ItemWidgetType.left),
              ItemWidget(
                label: "Model",
                value: controller.device['model'],
                itemType: ItemWidgetType.left),
              ItemWidget(
                label: "OS Platform",
                value: controller.device['os_platform'],
                itemType: ItemWidgetType.left),
              ItemWidget(
                label: "OS Version",
                value: controller.device['os_version'],
                itemType: ItemWidgetType.left),
              ItemWidget(
                label: "App Version",
                value: controller.device['app_version'],
                itemType: ItemWidgetType.left),
              ItemWidget(
                label: "UUID",
                value: controller.device['uuid'],
                itemType: ItemWidgetType.left),
            ]).show();
          },
          backgroundColor: initController.isValidHandset.value ? Colors.green : Colors.red,
          label: Text(initController.isValidHandset.value ? 'Valid' : 'Not Valid'),
          icon: initController.isValidHandset.value
              ? const Icon(Icons.mobile_friendly)
              : const Icon(Icons.phonelink_erase),
        )
      ),
    );
  }
}
