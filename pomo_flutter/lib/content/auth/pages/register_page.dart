import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/auth/utils/FormValidator.dart';
import 'package:PomoFlutter/content/auth/widgets/auth_generic_page.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_external_prividers.dart';
import '../widgets/my_text_form_fild.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
            mobile: RegisterBody(controller: controller),
            tablet: RegisterBody(controller: controller),
            desktop: RowDivider(
              bgColor: MyColors.PRIMARY.color,
              child: RegisterBody(controller: controller),
            )),
      ),
    );
  }
}

class RegisterBody extends StatelessWidget {
  const RegisterBody({
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
      title: "create_account".tr,
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
              validator: validator.isValidEmail,
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
            const SizedBox(height: 20),
            // Confirm Password
            MyTextFormFild(
              label: "confirm_password".tr,
              controller: controller.confirmPasswordController,
              color: MyColors.CONTRARY.color,
              icon: Icons.lock,
              validator: (text) => validator.isValidConfirmPass(
                text,
                controller.passwordController.text,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Terms and conditions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.acceptTermsAndConditions.value,
                    onChanged: (value) {
                      controller.acceptTermsAndConditions.value = value!;
                    },
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "accept_terms_and_conditions".tr,
                      style: MyTextStyles.p.textStyle.copyWith(
                        color: MyColors.INFO.color.withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      buttonText: "sing_up".tr,
      onButtonPressed: () {
        if (formKey.currentState!.validate()) {
          controller.registerWithEmailAndPassword(onSuccess: () {});
        }
      },
      isButtonEnable: controller.acceptTermsAndConditions,
      bottom: BottomExternalPrividers(
        controller: controller,
        text: "already_have_account".tr,
        buttonText: "sign_in".tr,
        buttonTextFuntion: () {
          Get.offNamed(Routes.LOGIN.path);
        },
      ),
    );
  }
}
