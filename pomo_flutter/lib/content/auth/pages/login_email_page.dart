import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/auth/utils/FormValidator.dart';
import 'package:PomoFlutter/content/auth/widgets/auth_generic_page.dart';
import 'package:PomoFlutter/content/auth/widgets/bottom_external_prividers.dart';
import 'package:PomoFlutter/content/auth/widgets/my_text_form_fild.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginEmailPage extends StatelessWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: LoginEmailBody(controller: controller),
          tablet: LoginEmailBody(controller: controller),
          desktop: RowDivider(
            bgColor: MyColors.PRIMARY.color,
            child: LoginEmailBody(controller: controller),
          ),
        ),
      ),
    );
  }
}

class LoginEmailBody extends StatelessWidget {
  const LoginEmailBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AuthController controller;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final FormValidator validator = FormValidator();
    return AuthGenericPage(
      onBack: () {
        Get.back();
      },
      title: "login_with_email".tr,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Email
            MyTextFormFild(
              label: "email".tr,
              controller: controller.emailController,
              color: MyColors.CONTRARY.color,
              icon: Icons.email,
              validator: validator.isValidName,
            ),
            const SizedBox(height: 20),
            // Password
            MyTextFormFild(
              label: "password".tr,
              controller: controller.passwordController,
              color: MyColors.CONTRARY.color,
              icon: Icons.lock,
              validator: validator.isValidPass,
              obscureText: true,
            ),
          ],
        ),
      ),
      buttonText: "sign_in".tr,
      onButtonPressed: () {
        if (formKey.currentState!.validate()) {
          controller.loginWithEmailAndPassword();
        }
      },
      isButtonEnable: true.obs,
      bottom: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.offNamed(Routes.FORGOT_PASSWORD.path);
              },
              child: Text(
                "forgot_password".tr,
                style: MyTextStyles.p.textStyle.copyWith(
                  color: MyColors.SECONDARY.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          BottomExternalPrividers(
            controller: controller,
            text: "dont_have_account".tr,
            buttonText: "create_account".tr,
            buttonTextFuntion: () {
              Get.offNamed(Routes.REGISTER.path);
            },
          ),
        ],
      ),
    );
  }
}
