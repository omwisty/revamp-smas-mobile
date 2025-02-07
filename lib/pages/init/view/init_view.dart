import 'dart:io';

import 'package:dio_interceptor_ui/dio_interceptor_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/app_config.dart';
import 'package:smartfren_attendance/pages/force_update/view/force_update_view.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';
import 'package:smartfren_attendance/pages/layout/view/layout_view.dart';
import 'package:smartfren_attendance/pages/login/view/login_view.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';

class InitView extends StatelessWidget {
  InitView({Key? key}) : super(key: key);
  final controller = Get.put(InitController());
  final _authManager = Get.put(AuthManager());
  final flavour = AppConfig.env;

  @override
  Widget build(BuildContext context) {
    NetworkInterceptorOverlay.attachTo(context);
    if(flavour.getEnvironmentName() == "Production") {
      return Obx(() {
        return _authManager.isRoot.value ?
          AlertDialog(
            title: const Text('Root Detection Alert'),
            content: const Text('Your device detected running on root access. This application cannot running on it. Please fix your device.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close App'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  exit(0);
                },
              ),
            ],
          )
          : controller.needUpdate.value ?
              ForceUpdateView() :
              _authManager.isLogged.value ? LayoutView() : LoginView();
      });
    } else {
      return Obx(() {
        return controller.needUpdate.value ?
            ForceUpdateView() :
            _authManager.isLogged.value ? LayoutView() : LoginView();
      });
    }
  }

}