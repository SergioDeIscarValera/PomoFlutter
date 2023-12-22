import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/my_button.dart';
import 'package:PomoFlutter/content/home/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    var showText = context.width > 600;
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: GenericTemplate(
          icon: Icons.arrow_back,
          onIconTap: () {
            Get.back();
          },
          title: "app_name".tr,
          body: WrapInMid(
            flex: 3,
            otherFlex: context.width > 600 ? 1 : 0,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "assets/images/trophy.png",
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "congratulations_title".tr,
                  textAlign: TextAlign.center,
                  style: MyTextStyles.h2.textStyle,
                ),
                const SizedBox(height: 15),
                Text(
                  "congratulations_body".tr,
                  textAlign: TextAlign.center,
                  style: MyTextStyles.p.textStyle,
                ),
                const SizedBox(height: 30),
                //Buttons
                MyButton(
                  onTap: () {
                    mainController.setPage(3);
                    Get.back();
                  },
                  color: MyColors.PRIMARY.color,
                  textColor: MyColors.LIGHT.color,
                  text: "view_statistics".tr,
                  icon: showText ? null : Icons.bar_chart,
                ),
                const SizedBox(height: 15),
                MyButton(
                  onTap: () {
                    mainController.setPage(0);
                    Get.back();
                  },
                  color: Get.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                  textColor: MyColors.CONTRARY.color,
                  text: "go_back".tr,
                  icon: showText ? null : Icons.home,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
