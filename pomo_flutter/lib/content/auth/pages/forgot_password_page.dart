import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/auth/utils/FormValidator.dart';
import 'package:PomoFlutter/content/auth/widgets/auth_generic_page.dart';
import 'package:PomoFlutter/content/auth/widgets/my_text_form_fild.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: ForgotPasswordBody(controller: controller),
          tablet: ForgotPasswordBody(controller: controller),
          desktop: RowDivider(
            bgColor: MyColors.PRIMARY.color,
            child: ForgotPasswordBody(controller: controller),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({
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
      title: "forgot_password".tr,
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
            )
          ],
        ),
      ),
      buttonText: "recover_password".tr,
      onButtonPressed: () {
        if (formKey.currentState!.validate()) {
          controller.passwordReset();
        }
      },
      isButtonEnable: true.obs,
    );
  }
}
