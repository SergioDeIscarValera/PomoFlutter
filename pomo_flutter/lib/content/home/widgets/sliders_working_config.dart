import 'package:PomoFlutter/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/widgets/my_splider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlidersWorkingConfig extends StatelessWidget {
  const SlidersWorkingConfig({
    super.key,
    required this.countWorkingSession,
    required this.onChangedCountWorkingSession,
    required this.timeWorkingSession,
    required this.onChangedTimeWorkingSession,
    required this.timeBreakSession,
    required this.onChangedTimeBreakSession,
    required this.timeLongBreakSession,
    required this.onChangedTimeLongBreakSession,
    required this.spaceBetween,
  });

  final double spaceBetween;

  final RxInt countWorkingSession;
  final Function(double) onChangedCountWorkingSession;
  final RxInt timeWorkingSession;
  final Function(double) onChangedTimeWorkingSession;
  final RxInt timeBreakSession;
  final Function(double) onChangedTimeBreakSession;
  final RxInt timeLongBreakSession;
  final Function(double) onChangedTimeLongBreakSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WrapInMid(
          flex: 4,
          otherFlex: context.width < 500 ? 0 : 1,
          child: Obx(
            () => MySplider(
              label: "task_form_input_count_working_session".tr,
              value: countWorkingSession.value.toInt(),
              onChanged: onChangedCountWorkingSession,
              min: 1,
              max: 20,
              divisions: 19,
              unit: "pomodoro_session_unit".tr,
            ),
          ),
        ),
        SizedBox(height: spaceBetween),
        //Slider for time of working session
        WrapInMid(
          flex: 4,
          otherFlex: context.width < 500 ? 0 : 1,
          child: Obx(
            () => MySplider(
              label: "task_form_input_time_working_session".tr,
              value: timeWorkingSession.value.toInt(),
              onChanged: onChangedTimeWorkingSession,
              min: 1,
              max: 120,
              divisions: 119,
              unit: "minute_unit".tr,
            ),
          ),
        ),
        SizedBox(height: spaceBetween),
        //Slider for time of break session
        WrapInMid(
          flex: 4,
          otherFlex: context.width < 500 ? 0 : 1,
          child: Obx(
            () => MySplider(
              label: "task_form_input_time_break_session".tr,
              value: timeBreakSession.value.toInt(),
              onChanged: onChangedTimeBreakSession,
              min: 1,
              max: 60,
              divisions: 59,
              unit: "minute_unit".tr,
            ),
          ),
        ),
        SizedBox(height: spaceBetween),
        //Slider for time of long break session
        WrapInMid(
          flex: 4,
          otherFlex: context.width < 500 ? 0 : 1,
          child: Obx(
            () => MySplider(
              label: "task_form_input_time_long_break_session".tr,
              value: timeLongBreakSession.value.toInt(),
              onChanged: onChangedTimeLongBreakSession,
              min: 1,
              max: 60,
              divisions: 59,
              unit: "minute_unit".tr,
            ),
          ),
        ),
      ],
    );
  }
}
