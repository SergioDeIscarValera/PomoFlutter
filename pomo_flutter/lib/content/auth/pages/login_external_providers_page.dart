import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_spliter.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/auth_generic_page.dart';
import '../widgets/item_external_provider_long.dart';

class LoginExternalProvidersPage extends StatelessWidget {
  const LoginExternalProvidersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
            mobile: LoginExternalProviders(controller: controller),
            tablet: LoginExternalProviders(controller: controller),
            desktop: RowDivider(
              bgColor: MyColors.PRIMARY.color,
              child: LoginExternalProviders(controller: controller),
            )),
      ),
    );
  }
}

class LoginExternalProviders extends StatelessWidget {
  const LoginExternalProviders({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AuthController controller;
  @override
  Widget build(BuildContext context) {
    return AuthGenericPage(
      title: "lets_in".tr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemExternalProviderLong(
            text: "sing_in_with_google".tr,
            image: "assets/images/google.png",
            onPressed: () {
              controller.loginWithGoogle();
            },
          ),
          const SizedBox(height: 40),
          MySpliter(text: "or".tr),
        ],
      ),
      buttonText: "sing_in_with_email".tr,
      onButtonPressed: () {
        Get.toNamed(Routes.LOGIN_EMAIL.path);
      },
      isButtonEnable: true.obs,
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "dont_have_account".tr,
            style: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.CONTRARY.color.withOpacity(0.75),
            ),
          ),
          const SizedBox(width: 10),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.REGISTER.path);
              },
              child: Text(
                "sign_up".tr,
                style: MyTextStyles.p.textStyle.copyWith(
                  color: MyColors.SECONDARY.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
