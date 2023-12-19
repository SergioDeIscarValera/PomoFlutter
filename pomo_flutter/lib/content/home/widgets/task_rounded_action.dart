import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TaskRoundedAction extends StatelessWidget {
  const TaskRoundedAction({
    super.key,
    required this.onTap,
    required this.task,
    required this.size,
  });

  final Function(Task) onTap;
  final Task task;
  final double size;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onTap(task);
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
