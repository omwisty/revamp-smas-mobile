import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/models/change_password/change_password_request_model.dart';
import 'package:smartfren_attendance/pages/profile/controller/profile_controller.dart';
import 'package:smartfren_attendance/services/auth_service.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';

class ChangePasswordController extends GetxController with CacheManager {
  late BuildContext context;
  final formGlobalKey = GlobalKey<FormBuilderState>();
  final _httpAuth = Get.put(AuthService());
  final _authManager = Get.put(AuthManager());
  final _profileController = Get.put(ProfileController());
  RxBool isLoading = false.obs;
  RxBool oldPassVisible = true.obs;
  RxBool newPassVisible = true.obs;
  RxBool confirmNewPassVisible = true.obs;
  RxString newPassword = "".obs;

  @override
  void onInit() {
    super.onInit();
    context = Get.context!;
  }

  togglePasswordShow(int type) {
    switch(type) {
      case 1:
        oldPassVisible.value = !oldPassVisible.value;
        break;
      case 2:
        newPassVisible.value = !newPassVisible.value;
        break;
      case 3:
        confirmNewPassVisible.value = !confirmNewPassVisible.value;
        break;
    }
    update();
  }

  onSubmitChangePassword() async {
    isLoading.value = true;

    ChangePasswordRequestModel changePasswordRequestModel = ChangePasswordRequestModel(
      oldPassword: formGlobalKey.currentState?.value['old_password'],
      newPassword: formGlobalKey.currentState?.value['new_password']
    );
    final response = await _httpAuth.fetchChangePassword(changePasswordRequestModel: changePasswordRequestModel);
    if (response.success) {
      var authenticate = {
        "user_id": getAuthenticate()!['user_id'],
        "password": formGlobalKey.currentState?.value['new_password'],
        "platform": Platform.isAndroid ? "Android" : "iOS",
        "app_version": getAuthenticate()!['app_version'],
        "uuid": getAuthenticate()!['uuid'],
        "imei": null,
        "imsi": null
      };
      _authManager.onSaveAuthenticate(authenticate);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Info'),
          content: const Text('After Change Password, this application will Re-Login. Do you agree?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
                _profileController.onSubmitSignOut();
              },
              child: const Text('YES'),
            ),
          ],
        ),
      );
      isLoading.value = false;
    } else {
      isLoading.value = false;
      SnackBarWidget(
        title: "Invalid",
        message: "${response.message}",
        type: SnackBarType.error
      ).show();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}