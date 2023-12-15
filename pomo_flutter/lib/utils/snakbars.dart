import 'package:PomoFlutter/themes/colors.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void snackError(String message) {
    Get.snackbar(
      "Error",
      message.tr,
      backgroundColor: MyColors.DANGER.color.withOpacity(0.5),
      colorText: MyColors.LIGHT.color,
    );
  }

  static void snackSuccess(String message) {
    Get.snackbar(
      "Success",
      message.tr,
      backgroundColor: MyColors.SUCCESS.color.withOpacity(0.5),
      colorText: MyColors.LIGHT.color,
    );
  }
}
