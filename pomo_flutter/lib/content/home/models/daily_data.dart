import 'package:PomoFlutter/content/home/models/task_category.dart';

class DailyData {
  final DateTime date;
  final Map<TaskCategory, CategoryTime> categoryTimes;

  DailyData({
    required this.date,
    required this.categoryTimes,
  });

  factory DailyData.empty({required DateTime date}) {
    return DailyData(
      date: date,
      categoryTimes: {
        for (var category in TaskCategory.values)
          category: CategoryTime(
            category: category,
            workingTime: 0,
            breakingTime: 0,
          )
      },
    );
  }

  factory DailyData.fromJson({required Map<String, dynamic> json}) {
    return DailyData(
      date: DateTime.parse(json["date"]),
      categoryTimes: {
        for (var e in json["categoryTimes"])
          TaskCategory.values.firstWhere(
            (element) => element.id == e["category"],
          ): CategoryTime.fromJson(e)
      },
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "categoryTimes": categoryTimes.values.map((e) => e.toJson()).toList(),
      };
}

class CategoryTime {
  final TaskCategory category;
  int workingTime;
  int breakingTime;

  CategoryTime({
    required this.category,
    required this.workingTime,
    required this.breakingTime,
  });

  factory CategoryTime.fromJson(Map<String, dynamic> json) => CategoryTime(
        category: TaskCategory.values
            .firstWhere((element) => element.id == json['category']),
        workingTime: json["workingTime"],
        breakingTime: json["breakingTime"],
      );

  Map<String, dynamic> toJson() => {
        "category": category.id,
        "workingTime": workingTime,
        "breakingTime": breakingTime,
      };
}

/*
{
  date: "2023-12-20T18:15:00.000",
  categoryTimes: [
    {
      category: "WORK",
      workingTime: 80,
      breakingTime: 1000,
    },
    {
      category: "PERSONAL",
      workingTime: 900,
      breakingTime: 78,
    },
    {
      category: "OTHER",
      workingTime: 50,
      breakingTime: 21,
    },
  ],
}
*/