import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TaskColor {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
  pink,
}

extension TaskColorsExtens on TaskColor {
  Color get color {
    switch (this) {
      case TaskColor.red:
        return MyColors.DANGER.color;
      case TaskColor.orange:
        return const Color(0xFFfd7e14);
      case TaskColor.yellow:
        return MyColors.WARNING.color;
      case TaskColor.green:
        return MyColors.SUCCESS.color;
      case TaskColor.blue:
        return MyColors.INFO.color;
      case TaskColor.purple:
        return const Color(0xFF6f42c1);
      case TaskColor.pink:
        return const Color(0xFFe83e8c);
    }
  }

  Color get inverse {
    switch (this) {
      case TaskColor.red:
        return MyColors.DANGER.inverse;
      case TaskColor.orange:
        return const Color.fromARGB(255, 120, 62, 16);
      case TaskColor.yellow:
        return MyColors.WARNING.inverse;
      case TaskColor.green:
        return MyColors.SUCCESS.inverse;
      case TaskColor.blue:
        return MyColors.INFO.inverse;
      case TaskColor.purple:
        return const Color.fromARGB(255, 50, 31, 86);
      case TaskColor.pink:
        return const Color.fromARGB(255, 123, 35, 76);
    }
  }

  String get name {
    switch (this) {
      case TaskColor.red:
        return "red_name".tr;
      case TaskColor.orange:
        return "orange_name".tr;
      case TaskColor.yellow:
        return "yellow_name".tr;
      case TaskColor.green:
        return "green_name".tr;
      case TaskColor.blue:
        return "blue_name".tr;
      case TaskColor.purple:
        return "purple_name".tr;
      case TaskColor.pink:
        return "pink_name".tr;
    }
  }

  String get id {
    switch (this) {
      case TaskColor.red:
        return "red";
      case TaskColor.orange:
        return "orange";
      case TaskColor.yellow:
        return "yellow";
      case TaskColor.green:
        return "green";
      case TaskColor.blue:
        return "blue";
      case TaskColor.purple:
        return "purple";
      case TaskColor.pink:
        return "pink";
    }
  }
}
