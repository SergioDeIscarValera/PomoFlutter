import 'dart:io';

import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    if (GetPlatform.isWeb) {
      Get.offNamed(Routes.LOGIN.path);
      return;
    }

    //Wait 2 seconds to show the splash screen
    sleep(const Duration(seconds: 2));

    final box = GetStorage();
    final bool? firstTime = box.read('firstTime');
    if (firstTime == null) {
      box.write('firstTime', false);
      Get.offNamed(Routes.FIRST_TIME.path);
    } else if (Get.currentRoute != Routes.LOGIN.path &&
        Get.currentRoute != Routes.MAIN.path) {
      Get.offNamed(Routes.LOGIN.path);
    }
  }
}
