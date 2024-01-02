import 'dart:convert';

import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/services/calendar_events_device.dart';
import 'package:PomoFlutter/content/home/services/interface_task_repository.dart';
import 'package:PomoFlutter/content/home/services/tasks_repository_firebase.dart';
import 'package:get/get.dart';

class TaskRepository implements ITaskRepository {
  static final TaskRepository _singleton = TaskRepository._internal();

  factory TaskRepository() {
    return _singleton;
  }

  TaskRepository._internal();

  final ITaskJsonRepository _taskJsonRepository = TaskRepositoryFirebase();
  final CalendarEventsDevice _calendarEventsDevice = CalendarEventsDevice();

  @override
  Future<int> count({required String idc}) {
    return _taskJsonRepository.count(idc: idc);
  }

  @override
  Future<void> delete({required Task entity, required String idc}) {
    _deleteTaskFromDeviceCalendar(entity.calendarId);
    return _taskJsonRepository.delete(entity: entity.toJson(), idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) {
    _deleteAllTasksFromDeviceCalendar(idc);
    return _taskJsonRepository.deleteAll(idc: idc);
  }

  @override
  Future<void> deleteById({required String id, required String idc}) {
    _deleteTaskFromDeviceCalendar(id);
    return _taskJsonRepository.deleteById(id: id, idc: idc);
  }

  @override
  Future<bool> exists({required Task entity, required String idc}) {
    return _taskJsonRepository.exists(entity: entity.toJson(), idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) {
    return _taskJsonRepository.existsById(id: id, idc: idc);
  }

  @override
  Future<List<Task>> findAll({required String idc}) async {
    var result = await _taskJsonRepository.findAll(idc: idc);
    return result.map((e) => Task.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<List<Task>> findAllByCategory(
      {required TaskCategory category, required String idc}) {
    return findAll(idc: idc).then((value) =>
        value.where((element) => element.category == category).toList());
  }

  /// returns all the tasks that are being completed on the day [dateTime],
  /// that is, that occur that day or that their completion has not yet occurred
  /// but if their start (or their start is that same day)
  @override
  Future<List<Task>> findAllByDay(
      {required DateTime dateTime, required String idc}) {
    return findAll(idc: idc).then((value) => value
        .where((element) =>
            _isSameDay(element.dateTime, dateTime) ||
            (element.dateTime.isBefore(dateTime) &&
                element.endDateTime.isAfter(dateTime)) ||
            _isSameDay(element.endDateTime, dateTime))
        .toList());
  }

  bool _isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  @override
  Future<Task?> findById({required String id, required String idc}) async {
    var json = await _taskJsonRepository.findById(id: id, idc: idc);
    if (json == null) {
      return null;
    }
    return Task.fromJson(json: jsonDecode(json));
  }

  @override
  Future<Task?> save({required Task entity, required String idc}) async {
    var result =
        await _taskJsonRepository.save(entity: entity.toJson(), idc: idc);
    if (result == null) {
      return null;
    }
    return Task.fromJson(json: jsonDecode(result));
  }

  @override
  Future<List<Task>?> saveAll(
      {required List<Task> entities, required String idc}) async {
    var jsonList = entities.map((e) => e.toJson()).toList();
    var result =
        await _taskJsonRepository.saveAll(entities: jsonList, idc: idc);
    if (result == null) {
      return null;
    }
    return result.map((e) => Task.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<void> deleteAllWhere({
    required List<String> ids,
    required String idc,
  }) {
    return _taskJsonRepository.deleteAllWhere(ids: ids, idc: idc);
  }

  @override
  void addListener({
    required String idc,
    required Function(List<Task>) listener,
  }) {
    _taskJsonRepository.addListener(
        idc: idc,
        listener: (jsonList) {
          var taskList =
              jsonList.map((e) => Task.fromJson(json: jsonDecode(e)));
          listener(taskList.toList());
        });
  }

  @override
  Future<Task?> saveWithDeviceCalendar(
      {required Task entity, required String idc}) async {
    var result =
        await _calendarEventsDevice.addTaskDeviceCalendar(task: entity);
    if (result == null) {
      return null;
    }
    return await save(entity: result, idc: idc);
  }

  Future<void> _deleteTaskFromDeviceCalendar(String id) async {
    if (GetPlatform.isWeb) return;
    if (await _calendarEventsDevice.isTaskByIdInDeviceCalendar(id: id)) {
      await _calendarEventsDevice.removeTaskByIdDeviceCalendar(id: id);
    }
  }

  Future<void> _deleteAllTasksFromDeviceCalendar(String idc) async {
    var tasks = await findAll(idc: idc);
    for (var task in tasks) {
      await _deleteTaskFromDeviceCalendar(task.calendarId);
    }
  }

  @override
  Future<List<Task>> findAllBetweenDates(
      {required DateTime start, required DateTime end, required String idc}) {
    return findAll(idc: idc).then((value) => value
        .where((element) =>
            element.dateTime.isAfter(start) && element.dateTime.isBefore(end))
        .toList());
  }
}
