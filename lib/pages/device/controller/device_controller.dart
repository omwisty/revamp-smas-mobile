import 'package:get/get.dart';
import 'package:smartfren_attendance/utils/device/device.dart';

class DeviceController extends GetxController {
  RxMap device = {}.obs;

  @override
  void onInit() async {
    super.onInit();
    var deviceInfo = await getDeviceInfo();
    device.addAll(deviceInfo);
  }
}