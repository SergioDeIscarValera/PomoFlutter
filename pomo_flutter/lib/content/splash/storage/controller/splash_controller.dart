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
    // Si la pagina actual es la de login o main no se hace nada
    Future.delayed(const Duration(seconds: 2), () {
      final box = GetStorage();
      final bool? firstTime = box.read('firstTime');
      if (firstTime == null) {
        box.write('firstTime', false);
        Get.offNamed(Routes.FIRST_TIME.path);
      } else if (Get.currentRoute != Routes.LOGIN.path &&
          Get.currentRoute != Routes.MAIN.path) {
        Get.offNamed(Routes.LOGIN.path);
      }
    });
  }
}
