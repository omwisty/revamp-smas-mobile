import 'package:smartfren_attendance/app_config.dart';
import 'package:smartfren_attendance/main.dart';

void main() async {
  AppConfig.setEnvironment(Environment.dev);
  await initializeApp();
}