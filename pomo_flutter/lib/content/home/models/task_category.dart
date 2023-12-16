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
}
