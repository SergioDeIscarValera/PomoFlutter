import 'package:PomoFlutter/content/home/storage/controller/task_form_controller.dart';
import 'package:get/get.dart';

class TaskFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskFormController>(() => TaskFormController());
  }
}
