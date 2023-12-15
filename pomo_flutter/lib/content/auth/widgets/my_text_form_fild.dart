import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class MyTextFormFild extends StatelessWidget {
  const MyTextFormFild({
    super.key,
    required this.label,
    required this.controller,
    required this.color,
    required this.validator,
    required this.icon,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final Color color;
  final bool obscureText;
  final IconData icon;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        labelText: label,
        labelStyle:
            MyTextStyles.p.textStyle.copyWith(color: color.withOpacity(0.75)),
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
    );
  }
}
