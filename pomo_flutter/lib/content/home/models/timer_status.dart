import 'dart:ui';

import 'package:PomoFlutter/themes/colors.dart';

enum TimerStatus {
  WORKING,
  BREAK,
}

extension TimerStatusExtension on TimerStatus {
  Color get color {
    switch (this) {
      case TimerStatus.WORKING:
        return MyColors.SUCCESS.color;
      case TimerStatus.BREAK:
        return MyColors.INFO.color;
    }
  }

  String get id {
    switch (this) {
      case TimerStatus.WORKING:
        return 'working';
      case TimerStatus.BREAK:
        return 'break';
    }
  }
}
