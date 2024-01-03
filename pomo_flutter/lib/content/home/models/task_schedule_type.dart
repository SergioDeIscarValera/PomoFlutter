import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TaskSheduleType {
  daily,
  weekly,
  monthly,
}

extension TaskSheduleTypeExtension on TaskSheduleType {
  String get name {
    switch (this) {
      case TaskSheduleType.daily:
        return "daily_name".tr;
      case TaskSheduleType.weekly:
        return "weekly_name".tr;
      case TaskSheduleType.monthly:
        return "monthly_name".tr;
    }
  }

  Color get color {
    switch (this) {
      case TaskSheduleType.daily:
        return MyColors.SUCCESS.color;
      case TaskSheduleType.weekly:
        return MyColors.INFO.color;
      case TaskSheduleType.monthly:
        return MyColors.WARNING.color;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskSheduleType.daily:
        return Icons.calendar_month;
      case TaskSheduleType.weekly:
        return Icons.date_range;
      case TaskSheduleType.monthly:
        return Icons.event;
    }
  }

  String get id {
    switch (this) {
      case TaskSheduleType.daily:
        return 'daily';
      case TaskSheduleType.weekly:
        return 'weekly';
      case TaskSheduleType.monthly:
        return 'monthly';
    }
  }

  Duration get duration {
    switch (this) {
      case TaskSheduleType.daily:
        return const Duration(days: 1);
      case TaskSheduleType.weekly:
        return const Duration(days: 7);
      case TaskSheduleType.monthly:
        return const Duration(days: 30);
    }
  }
}
