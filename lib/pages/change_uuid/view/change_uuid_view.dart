import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/change_uuid/controller/change_uuid_controller.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';
import 'package:smartfren_attendance/widgets/appbar_widget.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';
import 'package:smartfren_attendance/widgets/textinput_widget.dart';

class ChangeUuidView extends StatelessWidget {
  ChangeUuidView({Key? key}) : super(key: key);
  ChangeUuidController controller = Get.put(ChangeUuidController());
  InitController init = Get.put(InitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        preferredSize: Size(double.infinity, 50),
        title: "Change UUID",
        haveBack: true,
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
                  TextInputWidget(
                    label: "NIK karyawan (Employee Number)",
                    name: 'nik',
                    type: TextInputStyleType.border,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Obx(() =>
                    TextInputWidget(
                      label: "Password",
                      name: 'password',
                      type: TextInputStyleType.border,
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
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  TextInputWidget(
                    label: "UUID",
                    name: "uuid",
                    type: TextInputStyleType.border,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    initialValue: init.device['uuid'],
                    readOnly: true,
                  ),
                  Obx(() =>
                    ButtonWidget(
                      onTap: () async {
                        if (controller.formGlobalKey.currentState!.validate()) {
                          controller.formGlobalKey.currentState?.save();
                          controller.onSubmitChangeUuid();
                        }
                      },
                      child: controller.isLoading.value ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 25.0,
                      ) : const Center(
                        child: Text("CHANGE UUID",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1.0
                          )
                        ),
                      )
                    )
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

}