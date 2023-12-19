import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_rounded_action.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
    required this.onTap,
    this.bottomMargin = 10,
  });

  final Function(Task) onTap;
  final Task task;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    return Padding(
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
          TaskRoundedAction(
            onTap: onTap,
            task: task,
            size: size,
          ),
        ],
      ),
    );
  }
}
