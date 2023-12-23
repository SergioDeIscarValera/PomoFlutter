import 'dart:ui';

import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/utils/storage_keys.dart';
import 'package:PomoFlutter/firebase_options.dart';
import 'package:PomoFlutter/routes/app_pages.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/thrmes.dart';
import 'package:PomoFlutter/utils/localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!GetPlatform.isWeb) {
    await GetStorage.init();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var userThemeConfig = box.read(StorageKeys().themeMode);
    return GetMaterialApp(
      title: 'Pomo Flutter',
      debugShowCheckedModeBanner: false,
      theme: Themes.LIGHT.data,
      darkTheme: Themes.DARK.data,
      themeMode: userThemeConfig == null
          ? ThemeMode.system
          : userThemeConfig
              ? ThemeMode.dark
              : ThemeMode.light,

      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(
          AuthController(),
          permanent: true,
        );
      }),

      initialRoute: Routes.SPLASH.path,
      getPages: AppPages.routes,

      // Para que funcione el scroll con el mouse (drag)
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),

      translations: MyLocalizations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
