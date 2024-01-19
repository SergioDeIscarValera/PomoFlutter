import 'package:uuid/uuid.dart';

class TaskCheckListItem {
  late String _id;
  final String content;
  bool isDone;

  TaskCheckListItem({
    String? id,
    required this.content,
    this.isDone = false,
  }) {
    _id = id ?? const Uuid().v4();
  }

  factory TaskCheckListItem.fromJson({required Map<String, dynamic> json}) {
    return TaskCheckListItem(
      id: json['id'],
      content: json['content'],
      isDone: json['isDone'],
    );
  }

  String toJson() {
    return '''
    {
      "id": "$_id",
      "content": "$content",
      "isDone": $isDone
    }
    ''';
  }

  String get id => _id;

  @override
  String toString() {
    return toJson();
  }
}
