import 'package:get/get.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';

class SettingsController extends GetxController with CacheManager {
  final _autManager = Get.put(AuthManager());
  RxBool positioningValue = true.obs;
  RxBool biometricValue = false.obs;

  @override
  void onInit() {
    super.onInit();
    biometricValue.value = getBiometric() ?? false;
  }

  onChangePositioning(value) async {
    positioningValue.value = value;
  }

  onChangeBiometric(value) async {
    biometricValue.value = value;
    _autManager.onSaveBiometric(value);
  }

  @override
  void dispose() {
    super.dispose();
  }
}