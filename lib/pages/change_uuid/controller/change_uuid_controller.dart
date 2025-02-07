import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/models/change_uuid/change_uuid_request_model.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';
import 'package:smartfren_attendance/services/auth_service.dart';
import 'package:smartfren_attendance/utils/date/date.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';

class ChangeUuidController extends GetxController {
  late BuildContext context;
  final formGlobalKey = GlobalKey<FormBuilderState>();
  final _httpAuth = Get.put(AuthService());
  final _initController = Get.put(InitController());
  RxBool isLoading = false.obs;
  RxBool passwordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    context = Get.context!;
  }

  onSubmitChangeUuid() async {
    isLoading.value = true;
    ChangeUuidRequestModel changeUuidRequestModel = ChangeUuidRequestModel(
      userId: formGlobalKey.currentState?.value['nik'],
      password: formGlobalKey.currentState?.value['password'],
      newUuid: formGlobalKey.currentState?.value['uuid']
    );
    final response = await _httpAuth.fetchChangeUuid(changeUuidRequestModel: changeUuidRequestModel);
    if (response.errCode == 0) {
      isLoading.value = false;
      if(response.success) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Success Change UUID"),
            content: const Text("Success change UUID, Please re-login SMAS"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'BACK');
                  Navigator.pop(context, 'BACK');
                  _initController.checkHandset();
                },
                child: const Text('RE-LOGIN'),
              ),
            ],
          ),
        );
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Invalid Change UUID"),
            content: Text("Last update UUID on ${dateHumanFormat(DateTime.parse(response.lastUpdate))}, Please try again on next month."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'BACK');
                  Navigator.pop(context, 'BACK');
                },
                child: const Text('BACK'),
              ),
            ],
          ),
        );
      }
    } else {
      isLoading.value = false;
      SnackBarWidget(
        title: "Invalid Change UUID",
        message: response.message.toString(),
        type: SnackBarType.error
      ).show();
    }
  }

  void togglePasswordShow() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }
}