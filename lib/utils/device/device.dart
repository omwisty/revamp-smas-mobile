import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

Future<String> getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<Map<String, dynamic>> getDeviceInfo() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var version = await getVersion();
  Map<String, dynamic> device = {};
  if(Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    device.addAll({
      "manufacture": "Apple",
      "model": iosInfo.model,
      "os_platform": iosInfo.systemName,
      "os_version": iosInfo.systemVersion,
      "app_version": version,
      "uuid": deviceId,
    });
  } else {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device.addAll({
      "manufacture": androidInfo.manufacturer,
      "model": androidInfo.model,
      "os_platform": "Android",
      "os_version": androidInfo.version.release,
      "app_version": version,
      "uuid": deviceId,
    });
  }
  return device;
}