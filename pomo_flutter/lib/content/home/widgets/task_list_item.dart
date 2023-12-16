import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
    required this.mainController,
    this.bottomMargin = 10,
  });

  final MainController mainController;
  final Task task;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    return Padding(
      /*padding: EdgeInsets.only(
        bottom: bottomMargin,
      ),*/
      padding: const EdgeInsets.all(10),
      child: GenericContainer(
        children: [
          //Icon
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      task.color.color,
                      task.color.color.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: size,
                width: size,
                child: Icon(
                  task.category.icon,
                  size: 25,
                  color: Get.isDarkMode
                      ? MyColors.LIGHT.color
                      : task.color.inverse,
                ),
              ),
              const SizedBox(width: 10),
              //Texts
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: task.isFinished
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: MyTextStyles.p.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    task.description,
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: MyColors.CONTRARY.color.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  if (task.isFinished)
                    Text(
                      "task_completed".tr,
                      style: MyTextStyles.p.textStyle.copyWith(
                        color: MyColors.SUCCESS.color.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 10),
          //Play
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                //Por ahora
                mainController.clickTaskPlay(task.id);
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
          ),
        ],
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
