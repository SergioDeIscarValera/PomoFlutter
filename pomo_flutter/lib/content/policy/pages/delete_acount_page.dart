import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/auth/widgets/auth_generic_page.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAcountPage extends StatelessWidget {
  const DeleteAcountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: DeleteAcountBody(controller: controller),
          tablet: DeleteAcountBody(controller: controller),
          desktop: RowDivider(
            bgColor: MyColors.PRIMARY.color,
            child: DeleteAcountBody(controller: controller),
          ),
        ),
      ),
    );
  }
}

class DeleteAcountBody extends StatelessWidget {
  const DeleteAcountBody({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final AuthController controller;
  @override
  Widget build(BuildContext context) {
    return AuthGenericPage(
      title: "delete_account".tr,
      buttonColor: MyColors.DANGER,
      onBack: () {
        Get.back();
      },
      body: Column(
        children: [
          Icon(
            Icons.person_off,
            size: 100,
            color: MyColors.SECONDARY.color,
          ),
          const SizedBox(height: 25),
          Text(
            "delete_account_body".tr,
            style: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.SECONDARY.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      buttonText: "delete_account".tr,
      onButtonPressed: () {
        if (controller.firebaseUser == null ||
            controller.firebaseUser!.email == null) {
          MySnackBar.snackError("error_deleting_account".tr);
          return;
        }
        controller.removeUser();
      },
      isButtonEnable: true.obs,
    );
  }
}
