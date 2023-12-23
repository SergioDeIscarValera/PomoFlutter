import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.mapTasks,
    this.limit = false,
    this.scrollable = false,
    required this.itemList,
  });

  final bool limit;
  final bool scrollable;
  final RxMap<String, Task> mapTasks;
  final Widget Function(Task) itemList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (mapTasks.isEmpty) {
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
              var task = mapTasks.values.toList()[index];
              return itemList(task);
            },
            itemCount: limit && mapTasks.length > 5 ? 5 : mapTasks.length,
          );
        }
      },
    );
  }
}
