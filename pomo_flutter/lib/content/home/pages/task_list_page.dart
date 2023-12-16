import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/my_button.dart';
import '../widgets/task_list.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: TaskListBody(mainController: mainController),
          tablet: TaskListBody(mainController: mainController),
          desktop: TaskListBody(mainController: mainController),
        ),
      ),
    );
  }
}

class TaskListBody extends StatelessWidget {
  const TaskListBody({Key? key, required this.mainController})
      : super(key: key);

  final MainController mainController;
  @override
  Widget build(BuildContext context) {
    var showText = context.width > 600;
    return Obx(
      () => GenericTemplate(
        onIconTap: () {
          Get.back();
          mainController.setPage(0);
        },
        icon: Icons.arrow_back,
        title: "${"today_task".tr} (${mainController.todayTasks.length})",
        body: ListView(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                //Button to clear all done tasks
                Flexible(
                  child: MyButton(
                    onTap: () {
                      mainController.clearDoneTasks();
                    },
                    text: "clear_done_tasks".tr,
                    icon: showText ? null : Icons.clear_all,
                    color: MyColors.DANGER.color,
                    textColor: MyColors.LIGHT.color,
                  ),
                ),
                //Button to add new task
                Flexible(
                  child: MyButton(
                    onTap: () {
                      Get.back();
                      mainController.setPage(1);
                    },
                    text: "add_new_task".tr,
                    icon: showText ? null : Icons.add,
                    color: MyColors.SUCCESS.color,
                    textColor: MyColors.LIGHT.color,
                  ),
                ),
                //Button to mark all tasks as done
                Flexible(
                  child: MyButton(
                    onTap: () {
                      mainController.markAllTasksAsDone();
                    },
                    text: "mark_all_as_done".tr,
                    icon: showText ? null : Icons.done_all,
                    color: MyColors.SECONDARY.color,
                    textColor: MyColors.LIGHT.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TaskList(mainController: mainController),
          ],
        ),
      ),
    );
  }
}
