import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:smartfren_attendance/models/auth/signin_request_model.dart';
import 'package:smartfren_attendance/services/auth_service.dart';
import 'package:smartfren_attendance/utils/auth/auth_manager.dart';
import 'package:smartfren_attendance/utils/auth/cache_manager.dart';
import 'package:smartfren_attendance/utils/device/device.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';

class LoginController extends GetxController with CacheManager {
  final formGlobalKey = GlobalKey<FormBuilderState>();
  final LocalAuthentication biometric = LocalAuthentication();
  final _authManager = Get.put(AuthManager());
  final _httpAuth = Get.put(AuthService());
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  RxBool passwordVisible = true.obs;
  RxBool isLoading = false.obs;
  RxBool isBiometric = false.obs;
  RxBool isIOSFaceId = false.obs;
  RxMap device = {}.obs;
  RxString version = "".obs;
  // RxBool isValidHandset = false.obs;
  RxBool needUpdate = false.obs;

  @override
  void onInit() async {
    super.onInit();
    version.value = await getVersion();
    var deviceInfo = await getDeviceInfo();
    device.addAll(deviceInfo);

    checkBiometricSupport();
  }

  void togglePasswordShow() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  checkBiometricSupport() async {
    bool? biometricVal = false;
    bool canCheckBiometrics = await biometric.canCheckBiometrics;
    final bool canAuthenticate = canCheckBiometrics || await biometric.isDeviceSupported();
    biometricVal = getBiometric();
    if (canAuthenticate) {
      isBiometric.value = (biometricVal == true) ? true : false;

      List<BiometricType> availableBiometrics = await biometric.getAvailableBiometrics();
      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          isIOSFaceId.value = true;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          isIOSFaceId.value = false;
        }
      }
    }
  }

  Future<void> submitLogin() async {
    isLoading.value = true;
    _authManager.onSaveAuthenticate({
      "user_id": formGlobalKey.currentState?.value['username'],
      "password": formGlobalKey.currentState?.value['password'],
      "platform": Platform.isAndroid ? "Android" : "iOS",
      "app_version": version.value,
      "uuid": device['uuid'],
      // "uuid": "27a13e9fd8bef032",
      // "uuid": "f5258fb7d6e6d797",
      "imei": null,
      "imsi": null
    });

    SignInRequestModel signInRequestModel = SignInRequestModel(
      userId: formGlobalKey.currentState?.value['username'],
      password: formGlobalKey.currentState?.value['password'],
      platform: Platform.isAndroid ? "Android" : "iOS",
      appVersion: version.value,
      uuid: device['uuid'],
      // uuid: "27a13e9fd8bef032",
      // uuid: "f5258fb7d6e6d797",
      imei: "null",
      imsi: "null"
    );
    fetchLoginApi(signInRequestModel);
  }

  loginWithBiometrics() async {
    bool didAuthenticate = false;
    try {
      didAuthenticate = await biometric.authenticate(
        localizedReason: 'Scan your fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
      if(didAuthenticate) {
        isLoading.value = true;
        SignInRequestModel signInRequestModel = SignInRequestModel(
          userId: getAuthenticate()!['user_id'],
          password: getAuthenticate()!['password'],
          platform: Platform.isAndroid ? "Android" : "iOS",
          appVersion: version.value,
          uuid: getAuthenticate()!['uuid'],
          imei: "null",
          imsi: "null"
        );
        fetchLoginApi(signInRequestModel);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        biometric.stopAuthentication();
      }
      return;
    }
  }

  fetchLoginApi(SignInRequestModel signInRequestModel) async {
    final response = await _httpAuth.fetchSignIn(signInRequestModel: signInRequestModel);
    if (response.errCode == 0) {
      await _authManager.onLogin(response.token, response.userName);
      _authManager.isLogged.value = response.isLoggedIn;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      SnackBarWidget(
        title: "Invalid Login",
        message: response.message == "Invalid handset" ? "Invalid Handset. Silahkan registrasi via BPM pada menu HR > SMAS Registration" : "${response.message}",
        type: SnackBarType.error
      ).show();
    }
  }
}