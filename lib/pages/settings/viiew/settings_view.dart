import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/settings/controller/settings_controller.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 15.0)
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormBuilderSwitch(
                    title: const Text('Use alternate positioning service', style: TextStyle(fontSize: 18)),
                    name: 'positioning',
                    initialValue: controller.positioningValue.value,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: controller.onChangePositioning,
                  ),
                ],
              )
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 15.0)
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormBuilderSwitch(
                    title: const Text('Login using biometric', style: TextStyle(fontSize: 18)),
                    name: 'biometric',
                    initialValue: controller.biometricValue.value,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: controller.onChangeBiometric,
                  ),
                ],
              )
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed('/change-password');
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 15.0
                    )
                  ]
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}