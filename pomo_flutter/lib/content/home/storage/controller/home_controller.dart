import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxMap<String, Task> todayTasks = <String, Task>{}.obs;
  final Rx<TaskCategory?> categoryFilterSelected = Rx<TaskCategory?>(null);
  final RxMap<String, Task> filteredTask = <String, Task>{}.obs;

  final RxDouble _taskProgress = 0.0.obs;
  RxDouble get taskProgress => _taskProgress;

  final MainController mainController = Get.find();
  final TaskRepository _taskRepository = TaskRepository();

  @override
  void onInit() async {
    _taskProgress.value = _getFinishedPercentage(todayTasks);
    todayTasks.listen((event) {
      _taskProgress.value = _getFinishedPercentage(event);
      _filterTasks();
    });

    for (var task in todayTasks.values) {
      filteredTask[task.id] = task;
    }
    categoryFilterSelected.listen((event) {
      _filterTasks();
    });

    mainController.totalTasks.listen((event) {
      todayTasks.clear();
      event.forEach((key, value) {
        if (value.dateTime.day == mainController.now.value.day &&
            value.dateTime.month == mainController.now.value.month &&
            value.dateTime.year == mainController.now.value.year) {
          todayTasks[key] = value;
        }
      });
      _filterTasks();
    });

    super.onInit();
  }

  void clearDoneTasks() {
    _taskRepository.deleteAllWhere(
        ids: todayTasks.values
            .where(
                (task) => task.isFinished && filteredTask.values.contains(task))
            .map((e) => e.id)
            .toList(),
        idc: mainController.authController.firebaseUser!.email!);
  }

  void markAllTasksAsDone() {
    todayTasks.forEach((key, value) {
      if (!filteredTask.values.contains(value)) return;
      value.setAsDone();
    });
    _taskRepository.saveAll(
        entities: todayTasks.values
            .where((task) => filteredTask.values.contains(task))
            .toList(),
        idc: mainController.authController.firebaseUser!.email!);
  }

  double _getFinishedPercentage(Map<String, Task> map) {
    if (map.isEmpty) {
      return 0;
    }
    return map.values.where((task) => task.isFinished).length /
        map.length *
        100;
  }

  void setCategoryFilter(TaskCategory? value) {
    categoryFilterSelected.value = value;
  }

  void _filterTasks() {
    if (categoryFilterSelected.value == null) {
      for (var task in todayTasks.values) {
        filteredTask[task.id] = task;
      }
      return;
    }
    var todayTasksFiltered = todayTasks.values
        .where((task) => task.category == categoryFilterSelected.value)
        .toList();
    filteredTask.clear();
    for (var task in todayTasksFiltered) {
      filteredTask[task.id] = task;
    }
  }
}
