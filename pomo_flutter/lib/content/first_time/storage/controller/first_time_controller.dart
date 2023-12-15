import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstTimeController extends GetxController {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
  }

  void nextPage() {
    if (currentPage.value == 2) Get.offNamed(Routes.LOGIN.path);
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
