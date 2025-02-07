import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/change_password/controller/change_password_controller.dart';
import 'package:smartfren_attendance/widgets/appbar_widget.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';
import 'package:smartfren_attendance/widgets/textinput_widget.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);
  ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        preferredSize: Size(double.infinity, 50),
        title: "Change Password",
        haveBack: true
      ),
      body: SafeArea(
        child: FormBuilder(
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
                  Obx(() =>
                    TextInputWidget(
                      label: "Old Password",
                      name: "old_password",
                      type: TextInputStyleType.border,
                      isPassword: controller.oldPassVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () => controller.togglePasswordShow(1),
                        icon: Icon(
                          controller.oldPassVisible.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.grey,
                          size: 20.0
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    )
                  ),
                  const SizedBox(height: 16),
                  Obx(() =>
                    TextInputWidget(
                      label: "New Password",
                      name: "new_password",
                      type: TextInputStyleType.border,
                      isPassword: controller.newPassVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () => controller.togglePasswordShow(2),
                        icon: Icon(
                          controller.newPassVisible.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.grey,
                          size: 20.0
                        ),
                      ),
                      onChanged: (value) {
                        controller.newPassword.value = value!;
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    )
                  ),
                  const SizedBox(height: 16),
                  Obx(() =>
                    TextInputWidget(
                      label: "Confirm New Password",
                      name: "confirm_new_password",
                      type: TextInputStyleType.border,
                      isPassword: controller.confirmNewPassVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () => controller.togglePasswordShow(3),
                        icon: Icon(
                            controller.confirmNewPassVisible.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Colors.grey,
                            size: 20.0
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.equal(context, controller.newPassword.value)
                      ]),
                    )
                  ),
                  Obx(() =>
                    ButtonWidget(
                      onTap: () async {
                        if (controller.formGlobalKey.currentState!.validate()) {
                          controller.formGlobalKey.currentState?.save();
                          controller.onSubmitChangePassword();
                        }
                      },
                      child: controller.isLoading.value
                        ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 25.0,
                          )
                        : const Center(
                          child: Text("CHANGE PASSWORD",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.0
                            )
                          ),
                        )
                    )
                  ),
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}
