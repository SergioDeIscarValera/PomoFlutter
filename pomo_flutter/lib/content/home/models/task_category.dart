import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TaskCategory {
  work,
  personal,
  shopping,
  others,
}

extension TaskCategoryExten on TaskCategory {
  String get name {
    switch (this) {
      case TaskCategory.work:
        return "work_name".tr;
      case TaskCategory.personal:
        return "personal_name".tr;
      case TaskCategory.shopping:
        return "shopping_name".tr;
      case TaskCategory.others:
        return "others_name".tr;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.work:
        return Icons.work;
      case TaskCategory.personal:
        return Icons.person;
      case TaskCategory.shopping:
        return Icons.shopping_cart;
      case TaskCategory.others:
        return Icons.more_horiz;
    }
  }

  String get id {
    switch (this) {
      case TaskCategory.work:
        return "work";
      case TaskCategory.personal:
        return "personal";
      case TaskCategory.shopping:
        return "shopping";
      case TaskCategory.others:
        return "others";
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.work:
        return MyColors.DANGER.color;
      case TaskCategory.personal:
        return MyColors.PRIMARY.color;
      case TaskCategory.shopping:
        return MyColors.SUCCESS.color;
      case TaskCategory.others:
        return MyColors.WARNING.color;
    }
  }
}
