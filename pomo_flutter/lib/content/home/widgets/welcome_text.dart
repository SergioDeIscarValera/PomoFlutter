import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.authController,
    required this.mainController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    var userName = authController.firebaseUser?.displayName?.isEmpty ?? true
        ? authController.firebaseUser?.email?.split("@")[0] ?? "anonymous"
        : authController.firebaseUser?.displayName ?? "anonymous";
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Obx(
          () => Text(
            "${_getGoodTime(mainController.now.value.hour)}, ",
            style: MyTextStyles.p.textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.width < 500 ? 18 : 24,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Text(
          userName,
          style: MyTextStyles.p.textStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.width < 500 ? 18 : 24,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(width: 10),
        Image.asset(
          "assets/images/waving-hand.png",
          height: context.width < 500 ? 40 : 50,
        ),
      ],
    );
  }

  String _getGoodTime(int hour) {
    return switch (hour) {
      >= 0 && < 6 => 'good_night'.tr,
      >= 6 && < 12 => 'good_morning'.tr,
      >= 12 && < 19 => 'good_afternoon'.tr,
      _ => 'good_evening'.tr,
    };
  }
}
