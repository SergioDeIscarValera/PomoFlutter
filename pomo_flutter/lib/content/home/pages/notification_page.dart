import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/wrap_in_mid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/tasks/task_invitation_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: NotificationBody(mainController: mainController),
      ),
    );
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      icon: Icons.arrow_back,
      onIconTap: () {
        Get.back();
      },
      title: "notifications_title".tr,
      body: WrapInMid(
        flex: 3,
        otherFlex: context.width > 600 ? 1 : 0,
        child: ListView(
          children: [
            const SizedBox(height: 15),
            GenericContainer(
              direction: Axis.vertical,
              children: [
                Obx(
                  () => ExpansionTile(
                      childrenPadding: const EdgeInsets.symmetric(vertical: 20),
                      collapsedIconColor: MyColors.CONTRARY.color,
                      title: Text(
                        "pending_notifications".tr.replaceAll(
                            "{notifiCount}",
                            mainController.notifications
                                .where((noti) => !noti.state)
                                .length
                                .toString()),
                        style: MyTextStyles.h3.textStyle,
                        textAlign: TextAlign.center,
                      ),
                      children: mainController.notifications
                          .where((noti) => !noti.state)
                          .map((noti) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: TaskInvitationItem(
                                  noti: noti,
                                  onAccept: () {
                                    mainController.acceptTaskInvitation(noti);
                                  },
                                  onDecline: () {
                                    mainController.declineTaskInvitation(noti);
                                  },
                                ),
                              ))
                          .toList()),
                )
              ],
            ),
            const SizedBox(height: 15),
            GenericContainer(
              direction: Axis.vertical,
              children: [
                Obx(
                  () => ExpansionTile(
                    childrenPadding: const EdgeInsets.symmetric(vertical: 20),
                    collapsedIconColor: MyColors.CONTRARY.color,
                    title: Text(
                      "accepted_notifications".tr.replaceAll(
                          "{notifiCount}",
                          mainController.notifications
                              .where((noti) => noti.state)
                              .length
                              .toString()),
                      style: MyTextStyles.h3.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    children: mainController.notifications
                        .where((noti) => noti.state)
                        .map((noti) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: TaskInvitationItem(
                                noti: noti,
                                onDecline: () {
                                  mainController.declineTaskInvitation(noti);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
