import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGenericPage extends StatelessWidget {
  const AuthGenericPage({
    Key? key,
    this.onBack,
    required this.title,
    required this.body,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isButtonEnable,
    this.bottom,
  }) : super(key: key);
  final Function()? onBack;
  final String title;
  final Widget body;
  final String buttonText;
  final Function() onButtonPressed;
  final RxBool isButtonEnable;
  final Widget? bottom;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 60),
            // Titulo
            Text(
              title,
              style: MyTextStyles.h1.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Cuerpo
            body,
            const SizedBox(height: 40),
            // Boton
            Obx(
              () => MouseRegion(
                cursor: isButtonEnable.value
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: isButtonEnable.value ? onButtonPressed : null,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isButtonEnable.value
                          ? MyColors.PRIMARY.color
                          : MyColors.PRIMARY_EMPHSIS.color,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.PRIMARY.color.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: MyTextStyles.p.textStyle.copyWith(
                        fontSize: 18,
                        color: isButtonEnable.value
                            ? MyColors.LIGHT.color
                            : MyColors.LIGHT_EMPHSIS.color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Bottom
            if (bottom != null) bottom!,
          ],
        ),

        // Boton de atras
        onBack == null
            ? const SizedBox()
            : Positioned(
                top: 15,
                left: 15,
                child: IconButton(
                  onPressed: onBack,
                  icon: Icon(
                    Icons.arrow_back,
                    color: MyColors.CONTRARY.color,
                  ),
                ),
              ),
      ],
    );
  }
}
