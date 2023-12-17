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
