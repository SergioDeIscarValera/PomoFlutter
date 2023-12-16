import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskFormPage extends StatelessWidget {
  const TaskFormPage({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "task_form_title".tr,
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
