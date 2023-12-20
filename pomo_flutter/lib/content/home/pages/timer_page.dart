import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:PomoFlutter/content/home/storage/controller/home_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/task_list_item_timer.dart';
import 'package:PomoFlutter/content/home/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    HomeController homeController = Get.find();
    TimerController timerController = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: TimerBody(
          mainController: mainController,
          homeController: homeController,
          timerController: timerController,
        ),
      ),
    );
  }
}

class TimerBody extends StatelessWidget {
  const TimerBody({
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
    return GenericTemplate(
      icon: Icons.arrow_back,
      onIconTap: () {
        timerController.goBack(mainController);
      },
      title: "timer_title".tr,
      body: WrapInMid(
        flex: 3,
        otherFlex: context.width > 600 ? 1 : 0,
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Obx(
              () => TaskListItemTimer(
                task: timerController.taskSelected.value!,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Obx(
                () => Stack(
                  children: [
                    SfRadialGauge(
                      enableLoadingAnimation: false,
                      axes: [
                        RadialAxis(
                          minimum: 0,
                          maximum: timerController.currentMax.value,
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          pointers: [
                            RangePointer(
                              width: 18,
                              value: timerController.current.value,
                              cornerStyle: CornerStyle.bothCurve,
                              gradient: SweepGradient(
                                colors: [
                                  timerController.timerStatus.value.color,
                                  timerController.timerStatus.value.color
                                      .withOpacity(0.5),
                                ],
                              ),
                            ),
                          ],
                          axisLineStyle: AxisLineStyle(
                            color: Get.isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[300],
                            thickness: 18,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: timerController.isPlaying.value ? 40 : 0,
                      child: Center(
                        child: Text(
                          //"03:47",
                          //timerController.current.value.toStringAsFixed(0),
                          timerController.currentFormatted.value,
                          style: MyTextStyles.p.textStyle.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (timerController.isPlaying.value &&
                        timerController.timerStatus.value ==
                            TimerStatus.WORKING)
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: Text(
                            //"4 of 4 sessions",
                            "sessions_now"
                                .tr
                                .replaceAll(
                                    "{completed}",
                                    (timerController.taskSelected.value!
                                                .workSessionsCompleted +
                                            1)
                                        .toString())
                                .replaceAll(
                                    "{total}",
                                    timerController
                                        .taskSelected.value!.workSessions
                                        .toString()),
                            style: MyTextStyles.p.textStyle.copyWith(
                              color: MyColors.CONTRARY.color.withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            //Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  if (timerController.timerStatus.value ==
                      TimerStatus.WORKING) {
                    return MyIconButton(
                      icon: Icons.replay,
                      onTap: () {
                        timerController.resetTimer();
                      },
                      iconColor: MyColors.CONTRARY.color,
                      backgroundColor: Get.isDarkMode
                          ? Colors.grey[800]!
                          : Colors.grey[300]!,
                    );
                  } else {
                    return Container();
                  }
                }),
                Obx(
                  () => MyIconButton(
                    icon: timerController.isPlaying.value
                        ? Icons.pause
                        : Icons.play_arrow,
                    onTap: () {
                      timerController.pauseChangeTimer();
                    },
                    iconColor: MyColors.LIGHT.color,
                    backgroundColor: timerController.timerStatus.value.color,
                    size: 50,
                  ),
                ),
                Obx(() {
                  if (timerController.timerStatus.value ==
                      TimerStatus.WORKING) {
                    return MyIconButton(
                      icon: Icons.stop,
                      onTap: () {
                        timerController.stopTimer(mainController);
                      },
                      iconColor: MyColors.CONTRARY.color,
                      backgroundColor: Get.isDarkMode
                          ? Colors.grey[800]!
                          : Colors.grey[300]!,
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
