import 'package:get/get.dart';

class LayoutController extends GetxController {
  RxString title = "Attendance".obs;
  RxInt tabIndex = 2.obs;

  @override
  void onInit() {
    super.onInit();
  }

  onChangeTabIndex(int index) {
    tabIndex.value = index;
    switch (index) {
      case 0:
        title.value = "SMAS Log History";
        break;
      case 1:
        title.value = "Device Information";
        break;
      case 2:
        title.value = "Attendance";
        break;
      case 3:
        title.value = "Settings";
        break;
      case 4:
        title.value = "Profile";
        break;
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}