import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/init/controller/init_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InitController());
  }
}