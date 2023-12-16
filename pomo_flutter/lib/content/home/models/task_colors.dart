import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TaskColors {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
  pink,
}

extension TaskColorsExtens on TaskColors {
  Color get color {
    switch (this) {
      case TaskColors.red:
        return MyColors.DANGER.color;
      case TaskColors.orange:
        return const Color(0xFFfd7e14);
      case TaskColors.yellow:
        return MyColors.WARNING.color;
      case TaskColors.green:
        return MyColors.SUCCESS.color;
      case TaskColors.blue:
        return MyColors.INFO.color;
      case TaskColors.purple:
        return const Color(0xFF6f42c1);
      case TaskColors.pink:
        return const Color(0xFFe83e8c);
    }
  }

  Color get inverse {
    switch (this) {
      case TaskColors.red:
        return MyColors.DANGER.inverse;
      case TaskColors.orange:
        return Color.fromARGB(255, 120, 62, 16);
      case TaskColors.yellow:
        return MyColors.WARNING.inverse;
      case TaskColors.green:
        return MyColors.SUCCESS.inverse;
      case TaskColors.blue:
        return MyColors.INFO.inverse;
      case TaskColors.purple:
        return Color.fromARGB(255, 50, 31, 86);
      case TaskColors.pink:
        return Color.fromARGB(255, 123, 35, 76);
    }
  }

  String get name {
    switch (this) {
      case TaskColors.red:
        return "red_name".tr;
      case TaskColors.orange:
        return "orange_name".tr;
      case TaskColors.yellow:
        return "yellow_name".tr;
      case TaskColors.green:
        return "green_name".tr;
      case TaskColors.blue:
        return "blue_name".tr;
      case TaskColors.purple:
        return "purple_name".tr;
      case TaskColors.pink:
        return "pink_name".tr;
    }
  }
}
