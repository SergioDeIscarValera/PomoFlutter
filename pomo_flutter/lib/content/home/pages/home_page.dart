import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/task_list.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "app_name".tr,
      body: ListView(
        children: [
          TextField(),
          const SizedBox(height: 15),
          WelcomeText(
            authController: authController,
            mainController: mainController,
          ),
          const SizedBox(height: 20),
          TaskTotalStatus(mainController: mainController),
          const SizedBox(height: 30),
          ListOfTask(mainController: mainController),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ListOfTask extends StatelessWidget {
  const ListOfTask({
    super.key,
    required this.mainController,
  });

  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                "${"today_task".tr} (${mainController.todayTasks.length})",
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
          mainController: mainController,
          limit: true,
        )
      ],
    );
  }
}

class TaskTotalStatus extends StatelessWidget {
  const TaskTotalStatus({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainController mainController;
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
                mainController.taskProgress.value,
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
                  _getCustomMessage(mainController.taskProgress.round()),
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
                          mainController.todayTasks.values
                              .where((t) => t.isFinished)
                              .toList()
                              .length
                              .toString())
                      .replaceAll("{total}",
                          mainController.todayTasks.length.toString()),
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
              cornerStyle: CornerStyle.bothCurve,
              color: MyColors.SECONDARY.color,
            ),
            WidgetPointer(
              value: value - 2.5, // -2.5 to center the widget
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

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
    required this.authController,
    required this.mainController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    var userName = authController.firebaseUser?.displayName?.isEmpty ?? true
        ? authController.firebaseUser?.email?.split("@")[0] ?? "anonymous"
        : authController.firebaseUser?.displayName ?? "anonymous";
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Obx(
          () => Text(
            "${_getGoodTime(mainController.now.value.hour)}, ",
            style: MyTextStyles.p.textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.width < 500 ? 18 : 24,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Text(
          userName,
          style: MyTextStyles.p.textStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.width < 500 ? 18 : 24,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(width: 10),
        Image.asset(
          "assets/images/waving-hand.png",
          height: context.width < 500 ? 40 : 50,
        ),
      ],
    );
  }

  String _getGoodTime(int hour) {
    return switch (hour) {
      >= 0 && < 6 => 'good_night'.tr,
      >= 6 && < 12 => 'good_morning'.tr,
      >= 12 && < 19 => 'good_afternoon'.tr,
      _ => 'good_evening'.tr,
    };
  }
}
