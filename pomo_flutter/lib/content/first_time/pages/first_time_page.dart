import 'package:PomoFlutter/content/first_time/storage/controller/first_time_controller.dart';
import 'package:PomoFlutter/content/first_time/widgets/first_time_first_body.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_nav_page.dart';

class FirstTimePage extends StatelessWidget {
  const FirstTimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirstTimeController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              children: [
                // Primera pagina
                ResponsiveLayout(
                  mobile: FirstTimeBody(
                    text: "first_time_first_body".tr,
                    image: "assets/images/efficiency.png",
                  ),
                  tablet: FirstTimeBody(
                    text: "first_time_first_body".tr,
                    image: "assets/images/efficiency.png",
                  ),
                  desktop: RowDivider(
                    bgColor: MyColors.PRIMARY.color,
                    child: FirstTimeBody(
                      text: "first_time_first_body".tr,
                      image: "assets/images/efficiency.png",
                    ),
                  ),
                ),
                // Segunda pagina
                ResponsiveLayout(
                  mobile: FirstTimeBody(
                    text: "first_time_second_body".tr,
                    image: "assets/images/productivity.png",
                  ),
                  tablet: FirstTimeBody(
                    text: "first_time_second_body".tr,
                    image: "assets/images/productivity.png",
                  ),
                  desktop: RowDivider(
                    bgColor: MyColors.PRIMARY.color,
                    child: FirstTimeBody(
                      text: "first_time_second_body".tr,
                      image: "assets/images/productivity.png",
                    ),
                  ),
                ),
                // Tercera pagina
                ResponsiveLayout(
                  mobile: FirstTimeBody(
                    text: "first_time_third_body".tr,
                    image: "assets/images/coffee-break.png",
                  ),
                  tablet: FirstTimeBody(
                    text: "first_time_third_body".tr,
                    image: "assets/images/coffee-break.png",
                  ),
                  desktop: RowDivider(
                    bgColor: MyColors.PRIMARY.color,
                    child: FirstTimeBody(
                      text: "first_time_third_body".tr,
                      image: "assets/images/coffee-break.png",
                    ),
                  ),
                ),
              ],
            ),
            BottomNavPage(controller: controller)
          ],
        ),
      ),
    );
  }
}
