import 'dart:convert';

import 'package:PomoFlutter/content/home/models/daily_data.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/services/daily_data_repository_firebase.dart';
import 'package:PomoFlutter/content/home/services/interface_daily_data_repository.dart';

class DailyDataRepository implements IDailyDataRepository {
  static final DailyDataRepository _singleton = DailyDataRepository._internal();

  factory DailyDataRepository() {
    return _singleton;
  }

  DailyDataRepository._internal();

  final IDailyDataJsonRepository _dailyDataJsonRepository =
      DailyDataRepositoryFirebase();

  @override
  void addListener(
      {required String idc, required Function(List<DailyData> p1) listener}) {
    _dailyDataJsonRepository.addListener(
        idc: idc,
        listener: (jsonList) {
          var taskList = jsonList
              .map((e) => DailyData.fromJson(json: jsonDecode(e)))
              .toList();
          listener(taskList);
        });
  }

  @override
  Future<int> count({required String idc}) {
    return _dailyDataJsonRepository.count(idc: idc);
  }

  @override
  Future<void> delete({required DailyData entity, required String idc}) {
    return _dailyDataJsonRepository.delete(
        entity: jsonEncode(entity.toJson()), idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) {
    return _dailyDataJsonRepository.deleteAll(idc: idc);
  }

  @override
  Future<void> deleteAllWhere(
      {required List<DateTime> ids, required String idc}) {
    return _dailyDataJsonRepository.deleteAllWhere(
        ids: ids.map((e) => e.toIso8601String()).toList(), idc: idc);
  }

  @override
  Future<void> deleteById({required DateTime id, required String idc}) {
    return _dailyDataJsonRepository.deleteById(
        id: id.toIso8601String(), idc: idc);
  }

  @override
  Future<bool> exists({required DailyData entity, required String idc}) {
    return _dailyDataJsonRepository.exists(
        entity: jsonEncode(entity.toJson()), idc: idc);
  }

  @override
  Future<bool> existsById({required DateTime id, required String idc}) {
    return _dailyDataJsonRepository.existsById(
        id: id.toIso8601String(), idc: idc);
  }

  @override
  Future<List<DailyData>> findAll({required String idc}) {
    return _dailyDataJsonRepository.findAll(idc: idc).then((value) =>
        value.map((e) => DailyData.fromJson(json: jsonDecode(e))).toList());
  }

  @override
  Future<DailyData?> findById({required DateTime id, required String idc}) {
    return _dailyDataJsonRepository
        .findById(id: id.toIso8601String(), idc: idc)
        .then((value) =>
            value == null ? null : DailyData.fromJson(json: jsonDecode(value)));
  }

  @override
  Future<DailyData?> save(
      {required DailyData entity, required String idc}) async {
    var result = await _dailyDataJsonRepository.save(
        entity: jsonEncode(entity.toJson()), idc: idc);
    if (result == null) {
      return null;
    }
    return DailyData.fromJson(json: jsonDecode(result));
  }

  @override
  Future<List<DailyData>?> saveAll(
      {required List<DailyData> entities, required String idc}) async {
    var result = await _dailyDataJsonRepository.saveAll(
        entities: entities.map((e) => jsonEncode(e.toJson())).toList(),
        idc: idc);
    if (result == null) {
      return null;
    }
    return result.map((e) => DailyData.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<List<DailyData>> findAllBetweenDates({
    required DateTime start,
    required DateTime end,
    required String idc,
  }) {
    return findAll(idc: idc).then((value) => value
        .where((element) =>
            element.date.isAfter(start) && element.date.isBefore(end))
        .toList());
  }

  @override
  Future<MapEntry<int, int>> getWorkingAndBreackingOfCategory({
    required DateTime start,
    required DateTime end,
    required TaskCategory category,
    required String idc,
  }) async {
    var dailyDates =
        await findAllBetweenDates(start: start, end: end, idc: idc);
    var workingTime = 0;
    var breakingTime = 0;
    for (var dailyDate in dailyDates) {
      var categoryTime = dailyDate.categoryTimes[category] ??
          CategoryTime(
            category: category,
            breakingTime: 0,
            workingTime: 0,
          );
      workingTime += categoryTime.workingTime;
      breakingTime += categoryTime.breakingTime;
    }
    return MapEntry(workingTime, breakingTime);
  }

  @override
  Future<MapEntry<int, int>> getWorkingAndBreackingOfDate({
    required DateTime dateTime,
    required String idc,
  }) async {
    var dailyDate = await findById(id: dateTime, idc: idc);
    if (dailyDate == null) {
      return const MapEntry(0, 0);
    }
    return MapEntry(
      dailyDate.categoryTimes.values
          .map((e) => e.workingTime)
          .reduce((value, element) => value + element),
      dailyDate.categoryTimes.values
          .map((e) => e.breakingTime)
          .reduce((value, element) => value + element),
    );
  }
}
