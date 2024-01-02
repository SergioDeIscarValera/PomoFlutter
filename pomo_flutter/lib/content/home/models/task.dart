import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:uuid/uuid.dart';

import 'task_comment.dart';

class Task {
  late String _id;
  final String title;
  final String description;
  final DateTime dateTime;
  late DateTime endDateTime;
  final TaskCategory category;
  final TaskColor color;
  final int workSessions;
  final int workSessionTime;
  final int longBreakTime;
  final int shortBreakTime;
  late Map<String, TaskComment> _comments;

  String calendarId;

  int timeSpent;
  TimerStatus timerStatus;

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
    this.timeSpent = 0,
    this.timerStatus = TimerStatus.WORKING,
    List<TaskComment>? comments,
    this.calendarId = '',
    DateTime? endDateTime,
  }) : _workSessionsCompleted = workSessionsCompleted {
    this.endDateTime = endDateTime ?? dateTime.add(Duration(minutes: duration));
    _comments = comments == null
        ? {}
        : Map.fromEntries(
            comments.map(
              (e) => MapEntry(e.id, e),
            ),
          );
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
      timeSpent: json['timeSpent'],
      timerStatus: TimerStatus.values
          .firstWhere((element) => element.id == json['timerStatus']),
      comments: json['comments'] == null || json['comments'].isEmpty
          ? []
          : (json['comments'] as List<dynamic>)
              .map((e) => TaskComment.fromJson(json: e))
              .toList(),
      calendarId: json['calendarId'] ?? '',
      endDateTime: json['endDateTime'] != null
          ? DateTime.parse(json['endDateTime'])
          : null,
    );
  }

  String toJson() {
    return '''
    {
      "id": "$_id",
      "title": "$title",
      "description": "$description",
      "dateTime": "${dateTime.toIso8601String()}",
      "endDateTime": "${endDateTime.toIso8601String()}",
      "category": "${category.id}",
      "color": "${color.id}",
      "workSessions": $workSessions,
      "workSessionTime": $workSessionTime,
      "longBreakTime": $longBreakTime,
      "shortBreakTime": $shortBreakTime,
      "workSessionsCompleted": $_workSessionsCompleted,
      "timeSpent": $timeSpent,
      "timerStatus": "${timerStatus.id}",
      "comments": ${_comments.values.map((e) => e.toJson()).toList()},
      "calendarId": "$calendarId"
    }
    ''';
  }

  int get workSessionsCompleted => _workSessionsCompleted;
  String get id => _id;
  bool get isFinished => _workSessionsCompleted == workSessions;
  int get duration {
    // Por cada sesión de trabajo una de descanso pequeña pero cuando llegue a 4 de trabajo una de descanso grande
    var sum = workSessions * workSessionTime;
    sum += (workSessions / 4).floor() * longBreakTime;
    sum += ((workSessions / 4) * 3).floor() * shortBreakTime;
    return sum;
  }

  List<TaskComment> get comments => _comments.values.toList();

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

  void addComment(TaskComment comment) {
    _comments[comment.id] = comment;
    //Sort comments by date
    _comments = Map.fromEntries(_comments.entries.toList()
      ..sort((a, b) => b.value.dateTime.compareTo(a.value.dateTime)));
  }

  void removeComment(TaskComment comment) {
    _comments.remove(comment.id);
  }
}
