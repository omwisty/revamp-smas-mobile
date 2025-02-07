import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/report/controller/report_controller.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';
import 'package:smartfren_attendance/widgets/datepicker_widget.dart';

class ReportView extends StatelessWidget {
  ReportView({Key? key}) : super(key: key);
  ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 16.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DatePickerWidget(
                label: "Start Date",
                name: "start_date",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                onChanged: (value) => controller.onChangeDate(value),
              ),
              const SizedBox(height: 16),
              DatePickerWidget(
                label: "End Date",
                name: "end_date",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ),
              Obx(() =>
                ButtonWidget(
                  onTap: () async {
                    if (controller.formGlobalKey.currentState!.validate()) {
                      controller.formGlobalKey.currentState?.save();
                      controller.onGenerateReport();
                    }
                  },
                  child: controller.isLoading.value
                    ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 25.0,
                      )
                    : const Center(
                        child: Text("GENERATE LOG",
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
      )
    );
  }
}
