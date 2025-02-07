import 'dart:io';

import 'package:get/get.dart';
import 'package:smartfren_attendance/models/updates/updates_request_model.dart';
import 'package:smartfren_attendance/services/check_handset_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateController extends GetxController {
  final _httpCheck = Get.put(CheckHandsetService());
  RxString newVersion = "".obs;
  RxString linkUpdate = "".obs;

  @override
  void onInit() {
    super.onInit();
    getLinkUpdate();
  }

  getLinkUpdate() async {
    UpdatesRequestModel updatesRequestModel = UpdatesRequestModel(
      platform: Platform.isAndroid ? "Android" : "iOS",
    );
    final response = await _httpCheck.fetchNewUpdateLink(updatesRequestModel: updatesRequestModel);
    if (response.errCode == 0) {
      newVersion.value = response.version;
      linkUpdate.value = response.link;
    }
  }

  downloadLinkUpdate() async {
    Uri uri = Uri.parse(linkUpdate.value);
    _launchInBrowser(uri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}