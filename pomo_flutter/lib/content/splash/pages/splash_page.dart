import 'package:PomoFlutter/content/splash/storage/controller/splash_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? MyColors.PRIMARY_EMPHSIS.color
          : MyColors.PRIMARY.color.withOpacity(0.2),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
