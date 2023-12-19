import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:PomoFlutter/widgets/decoration_divider.dart';
import 'task_rounded_action.dart';

class TaskCalendaryListItem extends StatelessWidget {
  const TaskCalendaryListItem({
    super.key,
    required this.task,
    required this.now,
  });

  final Task task;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    var isNow = now.day == task.dateTime.day &&
        now.month == task.dateTime.month &&
        now.year == task.dateTime.year &&
        now.hour == task.dateTime.hour;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("hh:mm a").format(task.dateTime),
              style: MyTextStyles.p.textStyle.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      task.color.color.withOpacity(0.7),
                      task.color.color.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(context.width < 500 ? 12 : 24),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: MyTextStyles.p.textStyle.copyWith(
                            color: MyColors.LIGHT.color,
                            fontSize: context.width < 500 ? 18 : 22,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _getTimeFromTask(task),
                          style: MyTextStyles.p.textStyle.copyWith(
                            color: MyColors.LIGHT.color.withOpacity(0.8),
                            fontSize: context.width < 500 ? 12 : 16,
                          ),
                        ),
                      ],
                    ),
                    TaskRoundedAction(
                      onTap: (task) {},
                      task: task,
                      size: context.width < 500 ? 50.0 : 70.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isNow)
          DecorationDivider(
            color: MyColors.INFO.color,
            backgroundColor: MyColors.CURRENT.color,
          ),
      ],
    );
  }

  String _getTimeFromTask(Task task) {
    return "${DateFormat.Hm().format(task.dateTime)} - ${DateFormat.Hm().format(task.endDateTime)}";
  }
}
