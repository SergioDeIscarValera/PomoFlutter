import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/task_form_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/my_button.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/utils/form_validator.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/my_text_form_fild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/my_dropdown_button.dart';
import '../widgets/sliders_working_config.dart';
import '../../../widgets/wrap_in_mid.dart';

class TaskFormPage extends StatelessWidget {
  const TaskFormPage({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    TaskFormController taskFormController = Get.find();
    FormValidator formValidator = FormValidator();
    final formKey = GlobalKey<FormState>();
    const double spaceBetween = 25;
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "task_form_title".tr,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            //Button to save and button to clear
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: MyButton(
                    text: "task_form_button_clear".tr,
                    icon: Icons.delete_forever,
                    onTap: () {
                      taskFormController.resetForm();
                    },
                    color: MyColors.DANGER.color,
                    textColor: MyColors.LIGHT.color,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: MyButton(
                    text: "task_form_button_save".tr,
                    icon: Icons.save,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        taskFormController.saveTask();
                      }
                    },
                    color: MyColors.SUCCESS.color,
                    textColor: MyColors.LIGHT.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  //Title input
                  Text(
                    "task_form_input_title".tr,
                    style: MyTextStyles.p.textStyle,
                  ),
                  const SizedBox(height: 10),
                  MyTextFormFild(
                    label: "task_form_input_title".tr,
                    controller: taskFormController.titleController,
                    color: MyColors.CONTRARY.color,
                    validator: formValidator.isValidTaskName,
                    icon: Icons.title,
                    mainController: mainController,
                  ),
                  const SizedBox(height: spaceBetween),
                  //Description input
                  Text(
                    "task_form_input_description".tr,
                    style: MyTextStyles.p.textStyle,
                  ),
                  const SizedBox(height: 10),
                  MyTextFormFild(
                    label: "task_form_input_description".tr,
                    controller: taskFormController.descriptionController,
                    color: MyColors.CONTRARY.color,
                    validator: formValidator.isValidTaskDescription,
                    icon: Icons.description,
                    mainController: mainController,
                  ),
                  const SizedBox(height: spaceBetween),
                  //Date and time input
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              "task_form_input_date".tr,
                              style: MyTextStyles.p.textStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => _GenericContainerSplited(
                                text: DateFormat.yMd().format(
                                    taskFormController.selectedDate.value),
                                icon: Icons.calendar_month,
                                onTap: () {
                                  taskFormController.selectDate(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: context.width < 500 ? 10 : 20),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              "task_form_input_time".tr,
                              style: MyTextStyles.p.textStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => _GenericContainerSplited(
                                text: DateFormat.jm().format(
                                    taskFormController.selectedTime.value),
                                icon: Icons.access_time,
                                onTap: () {
                                  taskFormController.selectTime(context);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: spaceBetween),
                  //Category input
                  WrapInMid(
                    flex: 4,
                    otherFlex: context.width < 500 ? 0 : 1,
                    child: Column(
                      children: [
                        Text(
                          "task_form_input_category".tr,
                          style: MyTextStyles.p.textStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => MyDropdownButton<TaskCategory>(
                            value: taskFormController.selectedCategory.value,
                            onChanged: (value) {
                              taskFormController.selectCategory(value!);
                            },
                            items: TaskCategory.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spaceBetween),
                  //Color input
                  WrapInMid(
                    flex: 4,
                    otherFlex: context.width < 500 ? 0 : 1,
                    child: Column(
                      children: [
                        Text(
                          "task_form_input_color".tr,
                          style: MyTextStyles.p.textStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => MyDropdownButton<TaskColor>(
                            value: taskFormController.selectedColor.value,
                            onChanged: (value) {
                              taskFormController.selectColor(value!);
                            },
                            items: TaskColor.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: e,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            e.color,
                                            e.color.withOpacity(0.5),
                                          ],
                                        ),
                                        // Si es el primer item los dos bordes superiores son redondeados
                                        // Si es el ultimo item los dos bordes inferiores son redondeados
                                        // Si esta seleccionado el item los bordes son redondeados
                                        borderRadius: BorderRadius.vertical(
                                          top: (e == TaskColor.values.first ||
                                                  e ==
                                                      taskFormController
                                                          .selectedColor.value)
                                              ? const Radius.circular(16)
                                              : const Radius.circular(0),
                                          bottom: (e == TaskColor.values.last ||
                                                  e ==
                                                      taskFormController
                                                          .selectedColor.value)
                                              ? const Radius.circular(16)
                                              : const Radius.circular(0),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                      child: Center(
                                        child: Text(
                                          e.name,
                                          style: MyTextStyles.p.textStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spaceBetween),
                  //Slider for count working session
                  SlidersWorkingConfig(
                    countWorkingSession: taskFormController.countWorkingSession,
                    onChangedCountWorkingSession: (value) {
                      taskFormController.countWorkingSession.value =
                          value.round();
                    },
                    timeWorkingSession: taskFormController.timeWorkingSession,
                    onChangedTimeWorkingSession: (value) {
                      taskFormController.timeWorkingSession.value =
                          value.round();
                    },
                    timeBreakSession: taskFormController.timeBreakSession,
                    onChangedTimeBreakSession: (value) {
                      taskFormController.timeBreakSession.value = value.round();
                    },
                    timeLongBreakSession:
                        taskFormController.timeLongBreakSession,
                    onChangedTimeLongBreakSession: (value) {
                      taskFormController.timeLongBreakSession.value =
                          value.round();
                    },
                    spaceBetween: spaceBetween,
                  ),
                  const SizedBox(height: spaceBetween),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenericContainerSplited extends StatelessWidget {
  const _GenericContainerSplited({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: GenericContainer(
          children: [
            Text(
              text,
              style: MyTextStyles.p.textStyle,
              textAlign: TextAlign.center,
            ),
            Icon(
              icon,
              color: MyColors.PRIMARY.color,
            ),
          ],
        ),
      ),
    );
  }
}
