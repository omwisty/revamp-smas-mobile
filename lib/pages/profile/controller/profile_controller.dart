import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/layout/controller/layout_controller.dart';
import 'package:smartfren_attendance/pages/login/controller/login_controller.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';

class ProfileController extends GetxController with CacheManager {
  final _authManager = Get.put(AuthManager());
  final LayoutController _layoutController = Get.put(LayoutController());
  final LoginController _loginController = Get.put(LoginController());
  RxString nik = "".obs;
  RxString name = "".obs;

  @override
  void onInit() {
    super.onInit();
    onLoadUser();
  }

  onLoadUser() {
    nik.value = '${getAuthenticate()!['user_id'] ?? ""}';
    name.value = "${getUser()}";
  }

  onSubmitSignOut() async {
    _authManager.onLogout();
    _authManager.isLogged.value = false;
    _layoutController.tabIndex.value = 2;
    _loginController.checkBiometricSupport();
  }

  @override
  void dispose() {
    super.dispose();
  }
}