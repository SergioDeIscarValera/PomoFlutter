import 'package:PomoFlutter/content/first_time/storage/controller/first_time_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({
    super.key,
    required this.controller,
  });

  final FirstTimeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0.85),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotColor: MyColors.CONTRARY.color,
              activeDotColor: MyColors.PRIMARY.color,
              expansionFactor: 2.5,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              controller.nextPage();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: MyColors.PRIMARY.color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Obx(
                () => Text(
                  controller.currentPage.value == 2
                      ? "get_started".tr
                      : "next".tr,
                  style: MyTextStyles.p.textStyle.copyWith(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
