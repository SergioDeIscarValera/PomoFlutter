import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TaskCategory {
  work,
  personal,
  shopping,
  education,
  finance,
  health,
  home,
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
      case TaskCategory.education:
        return "education_name".tr;
      case TaskCategory.finance:
        return "finance_name".tr;
      case TaskCategory.health:
        return "health_name".tr;
      case TaskCategory.home:
        return "home_name".tr;
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
      case TaskCategory.education:
        return Icons.school;
      case TaskCategory.finance:
        return Icons.attach_money;
      case TaskCategory.health:
        return Icons.fitness_center;
      case TaskCategory.home:
        return Icons.home;
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
      case TaskCategory.education:
        return "education";
      case TaskCategory.finance:
        return "finance";
      case TaskCategory.health:
        return "health";
      case TaskCategory.home:
        return "home";
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
      case TaskCategory.education:
        return MyColors.INFO.color;
      case TaskCategory.finance:
        return const Color(0xFFfd7e14);
      case TaskCategory.health:
        return const Color(0xFFe83e8c);
      case TaskCategory.home:
        return const Color(0xFF6f42c1);
    }
  }
}
