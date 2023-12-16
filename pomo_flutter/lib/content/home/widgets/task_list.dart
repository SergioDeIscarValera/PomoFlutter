import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/task_list_item.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.mainController,
    this.limit = false,
  });

  final bool limit;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mainController.todayTasks.isEmpty) {
          return Center(
            child: Text(
              "no_task".tr,
              style: MyTextStyles.h2.textStyle,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var task = mainController.todayTasks.values.toList()[index];
              return TaskListItem(
                key: Key(task.id),
                task: task,
                mainController: mainController,
              );
            },
            itemCount: limit && mainController.todayTasks.length > 5
                ? 5
                : mainController.todayTasks.length,
          );
        }
      },
    );
  }
}
