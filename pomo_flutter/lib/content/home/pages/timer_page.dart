import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:PomoFlutter/content/home/storage/controller/home_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/comments_list.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/task_list_item_timer.dart';
import 'package:PomoFlutter/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:PomoFlutter/content/home/widgets/tasks/commet_item.dart';

import '../widgets/guest_list_item.dart';

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
    var isGoingBackTimer = false;
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
            Obx(() {
              if (timerController.taskSelected.value == null) {
                return Container();
              } else {
                return TaskListItemTimer(
                  task: timerController.taskSelected.value!,
                );
              }
            }),
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
            if (timerController.taskSelected.value!.amIPropietary)
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
                      return const SizedBox(width: 50);
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
                      return MyIconButton(
                        icon: Icons.skip_next,
                        onTap: () {
                          //timerController.stopTimer(mainController);
                          timerController.skipTimer();
                        },
                        iconColor: MyColors.CONTRARY.color,
                        backgroundColor: Get.isDarkMode
                            ? Colors.grey[800]!
                            : Colors.grey[300]!,
                      );
                    }
                  }),
                ],
              ),
            const SizedBox(height: 30),
            //Comments
            _genericContainerWithAction(
              title: "comments".tr,
              child: Obx(
                () => CommentsList(
                  listCommets: timerController.taskSelected.value?.comments,
                  itemList: (comment) => CommetItem(
                    comment: comment,
                    mainController: mainController,
                    timerController: timerController,
                    onOpen: () {
                      if (timerController.isPlaying.value) {
                        timerController.pauseChangeTimer();
                        isGoingBackTimer = true;
                      }
                    },
                    onClose: () {
                      if (isGoingBackTimer) {
                        timerController.pauseChangeTimer();
                        isGoingBackTimer = false;
                      }
                    },
                  ),
                ),
              ),
              onButtonTap: () {
                mainController.addComment(
                  timerController.taskSelected,
                  () {
                    if (timerController.isPlaying.value) {
                      timerController.pauseChangeTimer();
                      isGoingBackTimer = true;
                    }
                  },
                  () {
                    if (isGoingBackTimer) {
                      timerController.pauseChangeTimer();
                      isGoingBackTimer = false;
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            // Guests
            if (timerController.taskSelected.value!.amIPropietary)
              _genericContainerWithAction(
                title: "guests_title".tr,
                child: Obx(() {
                  if (timerController.taskSelected.value == null) {
                    return const SizedBox();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          timerController.taskSelected.value!.guests.length,
                      itemBuilder: (contex, index) {
                        var guest =
                            timerController.taskSelected.value!.guests[index];
                        return GuestListItem(
                          guest: guest,
                          onDecline: () {
                            mainController.removeGuest(
                              task: timerController.taskSelected.value,
                              guest: guest,
                            );
                          },
                        );
                      },
                    );
                  }
                }),
                onButtonTap: () {
                  mainController.addGuest(
                    timerController.taskSelected,
                    () {
                      if (timerController.isPlaying.value) {
                        timerController.pauseChangeTimer();
                        isGoingBackTimer = true;
                      }
                    },
                    () {
                      if (isGoingBackTimer) {
                        timerController.pauseChangeTimer();
                        isGoingBackTimer = false;
                      }
                    },
                  );
                },
              ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  GenericContainer _genericContainerWithAction({
    required Widget child,
    required Function() onButtonTap,
    required String title,
  }) {
    return GenericContainer(
      direction: Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: MyTextStyles.h2.textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            //Button to add comment
            MyIconButton(
              icon: Icons.add,
              onTap: onButtonTap,
              iconColor: MyColors.LIGHT.color,
              backgroundColor: MyColors.SUCCESS.color,
              size: 30,
            ),
          ],
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }
}
