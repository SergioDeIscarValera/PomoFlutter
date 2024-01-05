import 'package:PomoFlutter/content/home/models/daily_data.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/utils/generic_repository.dart';

abstract class IDailyDataRepository
    implements GenericRepository<DailyData, DateTime, String> {
  Future<MapEntry<int, int>> getWorkingAndBreackingOfDate({
    required DateTime dateTime,
    required String idc,
  });
  Future<List<DailyData>> findAllBetweenDates({
    required DateTime start,
    required DateTime end,
    required String idc,
  });
  Future<MapEntry<int, int>> getWorkingAndBreackingOfCategory({
    required DateTime start,
    required DateTime end,
    required TaskCategory category,
    required String idc,
  });
}

abstract class IDailyDataJsonRepository
    implements GenericRepository<String, String, String> {}
