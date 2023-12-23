import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/task_list_item.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class TaskListItemTimer extends StatelessWidget {
  const TaskListItemTimer({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return TaskListItem(
      task: task,
      tail: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${task.workSessionsCompleted}/${task.workSessions}",
            style: MyTextStyles.p.textStyle.copyWith(
              fontSize: 18,
            ),
            textAlign: TextAlign.end,
          ),
          Text(
            "${task.duration} minutes",
            style: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.CONTRARY.color.withOpacity(0.5),
              fontSize: 14,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
