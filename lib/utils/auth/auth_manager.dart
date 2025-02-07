import 'dart:io';

import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';

class AuthManager extends GetxController with CacheManager{
  final isLogged = false.obs;
  final isRoot = false.obs;

  Future onLogin(String? token, String? userName) async {
    await saveToken(token);
    await saveUser(userName);
  }

  void onLogout() {
    isLogged.value = false;
    removeToken();
  }

  void checkLogin() async {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }

  onSaveBiometric(bool biometric) async {
    await saveBiometric(biometric);
  }

  onSaveAuthenticate(Map<String, dynamic> auth) async {
    await saveAuthentication(auth);
  }

  onRootDetection() async {
    if(Platform.isIOS) {
      bool jailbroken = await FlutterJailbreakDetection.jailbroken;
      isRoot.value = jailbroken;
    }

    if(Platform.isAndroid) {
      bool developerMode = await FlutterJailbreakDetection.developerMode;
      isRoot.value = developerMode;
    }
  }

}