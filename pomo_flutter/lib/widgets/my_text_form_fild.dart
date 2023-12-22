import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextFormFild extends StatelessWidget {
  const MyTextFormFild({
    super.key,
    required this.label,
    required this.controller,
    required this.color,
    required this.validator,
    required this.icon,
    this.mainController,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final Color color;
  final bool obscureText;
  final IconData icon;
  final MainController? mainController;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          readOnly: GetPlatform.isMobile,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: color,
            ),
            labelText: label,
            labelStyle: MyTextStyles.p.textStyle
                .copyWith(color: color.withOpacity(0.75)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: color.withOpacity(0.5),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColors.PRIMARY.color,
                width: 2,
              ),
            ),
            errorStyle: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.DANGER.color,
              fontSize: 12,
            ),
          ),
          style: MyTextStyles.p.textStyle.copyWith(
            color: color,
          ),
        ),
        if (GetPlatform.isMobile)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                //ShowDialog for write text
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(label, style: MyTextStyles.h2.textStyle),
                      content: TextFormField(
                        autofocus: true,
                        controller: controller,
                        obscureText: obscureText,
                        validator: validator,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            icon,
                            color: color,
                          ),
                          labelText: label,
                          labelStyle: MyTextStyles.p.textStyle
                              .copyWith(color: color.withOpacity(0.75)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: color.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.PRIMARY.color,
                              width: 2,
                            ),
                          ),
                          errorStyle: MyTextStyles.p.textStyle.copyWith(
                            color: MyColors.DANGER.color,
                            fontSize: 12,
                          ),
                        ),
                        style: MyTextStyles.p.textStyle.copyWith(
                          color: color,
                        ),
                      ),
                      actions: [
                        MyIconButton(
                          onTap: () {
                            Get.back();
                          },
                          icon: Icons.check,
                          iconColor: MyColors.SUCCESS.color,
                          backgroundColor:
                              MyColors.SUCCESS.color.withOpacity(0.1),
                        ),
                      ],
                    );
                  },
                ).then((value) async {
                  await Future.delayed(const Duration(milliseconds: 350));
                  mainController?.setPage(2);
                });
              },
            ),
          )
      ],
    );
  }
}
