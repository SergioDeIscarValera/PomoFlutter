import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

enum MyTextStyles {
  h1,
  h2,
  h3,
  p,
  subtitle,
  link,
}

extension MyTextStylesExtension on MyTextStyles {
  TextStyle get textStyle {
    switch (this) {
      case MyTextStyles.h1:
        return TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: MyColors.PRIMARY.color,
        );
      case MyTextStyles.h2:
        return TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: MyColors.SECONDARY.color,
        );
      case MyTextStyles.h3:
        return TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: MyColors.CONTRARY.color,
        );
      case MyTextStyles.p:
        return TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: MyColors.CONTRARY.color,
        );
      case MyTextStyles.subtitle:
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: MyColors.SECONDARY.color,
        );
      case MyTextStyles.link:
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: MyColors.INFO.color,
        );
    }
  }
}
