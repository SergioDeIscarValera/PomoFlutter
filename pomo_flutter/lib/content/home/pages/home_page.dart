import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/home_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/task_list.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:PomoFlutter/content/home/widgets/task_list_item_play_action.dart';
import 'package:PomoFlutter/content/home/widgets/welcome_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.authController,
    required this.mainController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final TimerController timerController = Get.find();
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "app_name".tr,
      body: ListView(
        children: [
          const SizedBox(height: 15),
          WelcomeText(
            authController: authController,
            mainController: mainController,
          ),
          const SizedBox(height: 20),
          TaskTotalStatus(homeController: homeController),
          const SizedBox(height: 30),
          ListOfTask(
            homeController: homeController,
            timerController: timerController,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ListOfTask extends StatelessWidget {
  const ListOfTask({
    super.key,
    required this.homeController,
    required this.timerController,
  });

  final HomeController homeController;
  final TimerController timerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                "${"today_task".tr} (${homeController.todayTasks.length})",
                style: MyTextStyles.p.textStyle,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LIST_TASKS.path);
                },
                child: Text(
                  "see_all".tr,
                  style: MyTextStyles.link.textStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        TaskList(
          mapTasks: homeController.todayTasks,
          itemList: (task) => TaskListItemPlayAction(
            key: Key(task.id),
            task: task,
            timerController: timerController,
          ),
          limit: true,
        )
      ],
    );
  }
}

class TaskTotalStatus extends StatelessWidget {
  const TaskTotalStatus({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return GenericContainer(
      children: [
        Flexible(
          child: Obx(
            () => SizedBox(
              height: context.width < 500 ? 100 : 150,
              child: _totalTaskSlider(
                context,
                homeController.taskProgress.value,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: context.width < 500 ? 1 : 3,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getCustomMessage(homeController.taskProgress.round()),
                  style: MyTextStyles.p.textStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  //"12 of 16 completed!",
                  "completed_tasks"
                      .tr
                      .replaceAll(
                          "{completed}",
                          homeController.todayTasks.values
                              .where((t) => t.isFinished)
                              .toList()
                              .length
                              .toString())
                      .replaceAll("{total}",
                          homeController.todayTasks.length.toString()),
                  style: MyTextStyles.p.textStyle.copyWith(
                    fontSize: 14,
                    color: MyColors.CONTRARY.color.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getCustomMessage(int percentageDone) {
    return switch (percentageDone) {
      == 0 => "start_your_day".tr,
      >= 1 && < 25 => "starting_your_daily_task".tr,
      >= 25 && < 50 => "keep_going".tr,
      >= 50 && < 75 => "almost_there".tr,
      >= 75 && < 100 => "you_can_do_it".tr,
      _ => "you_did_it".tr,
    };
  }

  Widget _totalTaskSlider(
    BuildContext context,
    double value,
  ) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          radiusFactor: 0.8,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.1,
              widget: Text(
                "${value.round()}%",
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                  fontSize: context.width < 500 ? 20 : 26,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            RangePointer(
              value: value,
              cornerStyle:
                  value == 100 ? CornerStyle.bothFlat : CornerStyle.bothCurve,
              color: MyColors.SECONDARY.color,
            ),
            if (value != 100)
              WidgetPointer(
                value: value - 1.5, // -2.5 to center the widget
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.LIGHT.color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 5,
                  height: 5,
                ),
              ),
          ],
          axisLineStyle: AxisLineStyle(
            color: MyColors.CURRENT.color,
          ),
        )
      ],
    );
  }
}
