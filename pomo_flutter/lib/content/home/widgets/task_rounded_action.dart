import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TaskRoundedAction extends StatelessWidget {
  const TaskRoundedAction({
    super.key,
    required this.timerController,
    required this.task,
    required this.size,
  });

  final TimerController timerController;
  final Task task;
  final double size;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!task.isFinished) {
            timerController.selectTask(task);
            Get.toNamed(Routes.TIMER_PAGES.path);
          } else {
            Get.defaultDialog(
              title: 'delete_task'.tr,
              middleText: 'delete_task_message'.tr,
              textConfirm: "confirm".tr,
              textCancel: "cancel".tr,
              titleStyle: MyTextStyles.h2.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
              middleTextStyle: MyTextStyles.p.textStyle,
              cancelTextColor: MyColors.CONTRARY.color,
              confirmTextColor: MyColors.DANGER.color,
              backgroundColor:
                  Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
              buttonColor: MyColors.CURRENT.color,
              onConfirm: () {
                timerController.deleteTask(task);
                Get.back();
              },
              onCancel: () {
                Get.back();
              },
            );
          }
        },
        child: Stack(
          children: [
            _statusSlider(isFinished: task.isFinished),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: !task.isFinished
                      ? [
                          MyColors.SUCCESS.color,
                          MyColors.SUCCESS.color.withOpacity(0.5),
                        ]
                      : [
                          MyColors.DANGER.color,
                          MyColors.DANGER.color.withOpacity(0.5),
                        ],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              height: size,
              width: size,
              child: Icon(
                task.isFinished ? Icons.delete : Icons.play_arrow,
                size: 25,
                color: MyColors.LIGHT.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _statusSlider({required bool isFinished}) {
    return Positioned(
      bottom: 0,
      right: 0,
      top: 0,
      left: 0,
      child: Center(
          child: Transform.scale(
        scale: 1.5,
        child: SfRadialGauge(
          enableLoadingAnimation: !isFinished,
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: task.workSessions.toDouble(),
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              pointers: <GaugePointer>[
                RangePointer(
                  width: 5,
                  cornerStyle: CornerStyle.bothCurve,
                  value: task.workSessionsCompleted.toDouble(),
                  color: isFinished
                      ? MyColors.DANGER.color
                      : MyColors.SUCCESS.color,
                ),
              ],
              axisLineStyle: AxisLineStyle(
                color: MyColors.CURRENT.color,
                thickness: 5,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
