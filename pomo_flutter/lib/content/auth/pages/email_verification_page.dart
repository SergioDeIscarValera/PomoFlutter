import 'package:PomoFlutter/content/auth/storage/controller/email_verification_controller.dart';
import 'package:PomoFlutter/content/auth/widgets/auth_generic_page.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_spliter.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailVerificationController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: EmailVerificationBody(controller: controller),
          tablet: EmailVerificationBody(controller: controller),
          desktop: RowDivider(
            bgColor: MyColors.PRIMARY.color,
            child: EmailVerificationBody(controller: controller),
          ),
        ),
      ),
    );
  }
}

class EmailVerificationBody extends StatelessWidget {
  const EmailVerificationBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final EmailVerificationController controller;
  @override
  Widget build(BuildContext context) {
    return AuthGenericPage(
      title: "email_verification".tr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "images/auth-check.png",
            height: 200,
          ),
          const SizedBox(height: 75),
          Text(
            style: MyTextStyles.p.textStyle,
            textAlign: TextAlign.center,
            "email_verification_text".tr,
          ),
        ],
      ),
      buttonText: "check_email_verification".tr,
      onButtonPressed: () {
        controller.manualyCheckEmailVerificationStatus();
      },
      isButtonEnable: true.obs,
      bottom: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MySpliter(text: "not_received_email_verification".tr),
          const SizedBox(height: 25),
          TextButton(
            onPressed: () {
              controller.sendVerificationEmail();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              backgroundColor: MyColors.SECONDARY.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              "resend_email_verification".tr,
              style: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.LIGHT.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
