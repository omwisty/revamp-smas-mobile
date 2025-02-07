import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smartfren_attendance/app_config.dart';
import 'package:smartfren_attendance/models/presence/presence_model.dart';
import 'package:smartfren_attendance/pages/change_password/binding/change_password_binding.dart';
import 'package:smartfren_attendance/pages/change_password/view/change_password_view.dart';
import 'package:smartfren_attendance/pages/change_uuid/view/change_uuid_view.dart';
import 'package:smartfren_attendance/pages/init/binding/init_binding.dart';
import 'package:smartfren_attendance/pages/init/view/init_view.dart';
import 'package:smartfren_attendance/pages/profile/controller/profile_controller.dart';
import 'package:smartfren_attendance/pages/report/view/report_list_view.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cron = Cron();
  cron.schedule(Schedule.parse('59 23 * * *'), () async {
    final _profileController = Get.put(ProfileController());
    _profileController.onSubmitSignOut();
  });

  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(PresenceModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final flavour = AppConfig.env;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Smartfren Attendance',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        getPages: [
          GetPage(name: "/init", page: () => InitView(), binding: InitBinding()),
          GetPage(name: "/report-list", page: () => ReportListView()),
          GetPage(name: "/change-password", page: () => ChangePasswordView(), binding: ChangePasswordBinding()),
          GetPage(name: "/change-uuid", page: () => ChangeUuidView())
        ],
        initialRoute: "/init",
        debugShowCheckedModeBanner: flavour.getEnvironmentName() == "Production" ? false : true,
        supportedLocales: const [
          Locale('id'),
          Locale('en')
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate
        ],
        navigatorObservers: [],
      )
    );
  }
}
