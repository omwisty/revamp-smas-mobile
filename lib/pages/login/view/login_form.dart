import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';
import 'package:smartfren_attendance/pages/login/controller/login_controller.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';
import 'package:smartfren_attendance/widgets/textinput_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    var _initController = Get.put(InitController());
    return FormBuilder(
      key: controller.formGlobalKey,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text("Hello Smartfrenzie", style: TextStyle(fontSize: 20, letterSpacing: .6)),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text("Sign in to your account", style: TextStyle(fontSize: 14)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              TextInputWidget(
                label: "NIK karyawan (Employee Number)",
                name: 'username',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Obx(() =>
                TextInputWidget(
                  label: "Password",
                  name: 'password',
                  isPassword: controller.passwordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: controller.togglePasswordShow,
                    icon: Icon(
                      controller.passwordVisible.value
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                      color: Colors.grey,
                      size: 20.0
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
              ),
              Obx(() => ButtonWidget(
                onTap: () async {
                  if (!controller.isLoading.value) {
                    if (controller.formGlobalKey.currentState!.validate()) {
                      controller.formGlobalKey.currentState?.save();
                      controller.submitLogin();
                    }
                  }
                  // if (_initController.isValidHandset.value) {
                  //   if (!controller.isLoading.value) {
                  //     if (controller.formGlobalKey.currentState!.validate()) {
                  //       controller.formGlobalKey.currentState?.save();
                  //       controller.submitLogin();
                  //     }
                  //   }
                  // } else {
                  //   SnackBarWidget(
                  //     title: "Info",
                  //     message: "Handset is invalid, Register your device first",
                  //     type: SnackBarType.info
                  //   ).show();
                  // }
                },
                child: controller.isLoading.value
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 25.0,
                    )
                  : const Center(
                      child: Text("SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1.0)
                      ),
                    ),
                )
              ),
              Obx(() => controller.isBiometric.value
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () => controller.loginWithBiometrics(),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.black12,
                            radius: 30.0,
                            child: Icon(
                              controller.isIOSFaceId.value
                                ? Icons.face_unlock_rounded
                                : Icons.fingerprint,
                              size: 40,
                              color: Colors.green
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox())
            ],
          ),
        ),
      )
    );
  }
}
