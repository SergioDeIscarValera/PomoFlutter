import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/storage/controller/home_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/task_list_item_play_action.dart';
import 'package:PomoFlutter/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PomoFlutter/content/home/widgets/my_button.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/task_list.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    HomeController homeController = Get.find();
    TimerController timerController = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: TaskListBody(
          mainController: mainController,
          homeController: homeController,
          timerController: timerController,
        ),
      ),
    );
  }
}

class TaskListBody extends StatelessWidget {
  const TaskListBody({
    Key? key,
    required this.mainController,
    required this.homeController,
    required this.timerController,
  }) : super(key: key);

  final MainController mainController;
  final HomeController homeController;
  final TimerController timerController;

  @override
  Widget build(BuildContext context) {
    var showText = context.width > 600;
    return Obx(
      () => GenericTemplate(
        titleSize: 28,
        onIconTap: () {
          Get.back();
          mainController.setPage(0);
        },
        icon: Icons.arrow_back,
        title: "${"today_task".tr} (${homeController.filteredTask.length})",
        body: Column(
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
                      homeController.clearDoneTasks();
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
                      mainController.setPage(2);
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
                      homeController.markAllTasksAsDone();
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
            WrapInMid(
              otherFlex: context.width > 1100 ? 1 : 0,
              child: Obx(
                () => MyDropdownButton<TaskCategory?>(
                  onChanged: (value) {
                    homeController.setCategoryFilter(value);
                  },
                  value: homeController.categoryFilterSelected.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "see_all".tr,
                            style: MyTextStyles.p.textStyle,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.all_inclusive,
                            color: MyColors.CONTRARY.color,
                          )
                        ],
                      ),
                    ),
                    ...TaskCategory.values.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.name,
                              style: MyTextStyles.p.textStyle,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              e.icon,
                              color: MyColors.CONTRARY.color,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: WrapInMid(
                  otherFlex: context.width > 1100 ? 1 : 0,
                  child: TaskList(
                    mapTasks: homeController.filteredTask,
                    itemList: (task) => TaskListItemPlayAction(
                      key: Key(task.id),
                      task: task,
                      timerController: timerController,
                    ),
                    scrollable: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
