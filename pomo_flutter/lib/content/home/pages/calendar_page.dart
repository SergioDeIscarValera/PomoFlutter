import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/calendary_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/task_list.dart';
import 'package:PomoFlutter/content/home/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/calendary_list_item.dart';
import '../widgets/task_calendary_list_item.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key? key,
    required this.authController,
    required this.mainController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    final CalendaryController calendaryController = Get.find();
    return GenericTemplate(
      title: "calendar_title".tr,
      onIconTap: () {
        mainController.setPage(0);
      },
      body: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    calendaryController.changeMonth(-1);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.CONTRARY.color,
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    calendaryController.openDatePicker(context);
                  },
                  child: Obx(
                    () => Text(
                      DateFormat.yMMMM()
                          .format(calendaryController.selectedDate.value),
                      style: MyTextStyles.p.textStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    calendaryController.changeMonth(1);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: MyColors.CONTRARY.color,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Obx(
            () => WrapInMid(
              flex: context.width > 800 ? 3 : 2,
              otherFlex: context.width > 800 ? 1 : 0,
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: calendaryController.weekDays
                          .map(
                            (e) => CalendaryListItem(
                              date: e,
                              onTap: (value) {
                                calendaryController.setSelectedDate(value);
                              },
                              isSelect: e.day ==
                                  calendaryController.selectedDate.value.day,
                              now: mainController.now.value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: TaskList(
                mapTasks: calendaryController.selectedDayTasks,
                itemList: (task) => TaskCalendaryListItem(
                  key: Key(task.id),
                  task: task,
                  now: mainController.now.value,
                ),
                scrollable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
