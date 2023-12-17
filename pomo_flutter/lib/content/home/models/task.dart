import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:uuid/uuid.dart';

class Task {
  late String _id;
  final String title;
  final String description;
  final DateTime dateTime;
  final TaskCategory category;
  final TaskColor color;
  final int workSessions;
  final int workSessionTime;
  final int longBreakTime;
  final int shortBreakTime;

  int _workSessionsCompleted;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.category,
    required this.color,
    required this.workSessions,
    required this.workSessionTime,
    required this.longBreakTime,
    required this.shortBreakTime,
    int workSessionsCompleted = 0,
  }) : _workSessionsCompleted = workSessionsCompleted {
    _id = id ?? const Uuid().v4();
  }

  factory Task.fromJson({required Map<String, dynamic> json}) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      category: TaskCategory.values
          .firstWhere((element) => element.id == json['category']),
      color:
          TaskColor.values.firstWhere((element) => element.id == json['color']),
      workSessions: json['workSessions'],
      workSessionTime: json['workSessionTime'],
      longBreakTime: json['longBreakTime'],
      shortBreakTime: json['shortBreakTime'],
      workSessionsCompleted: json['workSessionsCompleted'],
    );
  }

  String toJson() {
    return '''
    {
      "id": "$_id",
      "title": "$title",
      "description": "$description",
      "dateTime": "${dateTime.toIso8601String()}",
      "category": "${category.id}",
      "color": "${color.id}",
      "workSessions": $workSessions,
      "workSessionTime": $workSessionTime,
      "longBreakTime": $longBreakTime,
      "shortBreakTime": $shortBreakTime,
      "workSessionsCompleted": $_workSessionsCompleted
    }
    ''';
  }

  int get workSessionsCompleted => _workSessionsCompleted;
  String get id => _id;
  bool get isFinished => _workSessionsCompleted == workSessions;

  void addWorkSession() {
    if (_workSessionsCompleted < workSessions) {
      _workSessionsCompleted++;
    }
  }

  void resetWorkSessions() {
    _workSessionsCompleted = 0;
  }

  void setAsDone() {
    _workSessionsCompleted = workSessions;
  }
}
