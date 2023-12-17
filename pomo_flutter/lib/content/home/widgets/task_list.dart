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
    this.scrollable = false,
    this.filtered = false,
  });

  final bool limit;
  final bool scrollable;
  final bool filtered;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var list = filtered
            ? mainController.filteredTask
            : mainController.todayTasks.values.toList();
        if (list.isEmpty) {
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
            physics: scrollable
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var task = list[index];
              return TaskListItem(
                key: Key(task.id),
                task: task,
                mainController: mainController,
              );
            },
            itemCount: limit && list.length > 5 ? 5 : list.length,
          );
        }
      },
    );
  }
}
