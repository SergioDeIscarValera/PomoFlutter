import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/content/home/widgets/task_list_item.dart';
import 'package:PomoFlutter/content/home/widgets/task_rounded_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListItemPlayAction extends StatelessWidget {
  const TaskListItemPlayAction({
    Key? key,
    required this.task,
    required this.timerController,
  }) : super(key: key);

  final TimerController timerController;
  final Task task;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    return TaskListItem(
      task: task,
      tail: TaskRoundedAction(
        timerController: timerController,
        task: task,
        size: size,
      ),
    );
  }
}
