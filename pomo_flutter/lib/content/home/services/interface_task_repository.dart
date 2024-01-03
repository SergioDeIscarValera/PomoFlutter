import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/utils/generic_repository.dart';

abstract class ITaskRepository
    implements GenericRepository<Task, String, String> {
  Future<List<Task>> findAllByDay(
      {required DateTime dateTime, required String idc});
  Future<List<Task>> findAllBetweenDates(
      {required DateTime start, required DateTime end, required String idc});
  Future<List<Task>> findAllByCategory(
      {required TaskCategory category, required String idc});
  Future<Task?> saveWithDeviceCalendar(
      {required Task entity, required String idc});
  Future<void> sheduleNextTask({required Task task, required String idc});
}

abstract class ITaskJsonRepository
    implements GenericRepository<String, String, String> {}
