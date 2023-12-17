import 'dart:convert';

import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/services/interface_task_repository.dart';
import 'package:PomoFlutter/content/home/services/tasks_repository_firebase.dart';

class TaskRepository implements ITaskRepository {
  static final TaskRepository _singleton = TaskRepository._internal();

  factory TaskRepository() {
    return _singleton;
  }

  TaskRepository._internal();

  final ITaskJsonRepository _taskJsonRepository = TaskRepositoryFirebase();

  @override
  Future<int> count({required String idc}) {
    return _taskJsonRepository.count(idc: idc);
  }

  @override
  Future<void> delete({required Task entity, required String idc}) {
    return _taskJsonRepository.delete(entity: entity.toJson(), idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) {
    return _taskJsonRepository.deleteAll(idc: idc);
  }

  @override
  Future<void> deleteById({required String id, required String idc}) {
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
      {required TaskCategory category, required String idc}) async {
    var result = await _taskJsonRepository.findAllByCategory(
        category: category, idc: idc);
    return result.map((e) => Task.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<List<Task>> findAllByDay(
      {required DateTime dateTime, required String idc}) async {
    var result =
        await _taskJsonRepository.findAllByDay(dateTime: dateTime, idc: idc);
    return result.map((e) => Task.fromJson(json: jsonDecode(e))).toList();
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
}
