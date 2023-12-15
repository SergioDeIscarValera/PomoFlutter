import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/auth/widgets/item_external_provider_small.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_spliter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomExternalPrividers extends StatelessWidget {
  const BottomExternalPrividers({
    super.key,
    required this.controller,
    required this.text,
    required this.buttonText,
    required this.buttonTextFuntion,
  });
  final AuthController controller;
  final String text;
  final String buttonText;
  final Function() buttonTextFuntion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MySpliter(text: "or".tr),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ItemExternalProviderSmall(
              image: "assets/images/google.png",
              onPressed: () {
                controller.loginWithGoogle();
              },
            ),
            const SizedBox(width: 10),
            ItemExternalProviderSmall(
              image: "assets/images/github.png",
              onPressed: () {
                controller.loginWithGithub();
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.CONTRARY.color.withOpacity(0.75),
              ),
            ),
            const SizedBox(width: 10),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  buttonTextFuntion();
                },
                child: Text(
                  buttonText,
                  style: MyTextStyles.p.textStyle.copyWith(
                    color: MyColors.SECONDARY.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
