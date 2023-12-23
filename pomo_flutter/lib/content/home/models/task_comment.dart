import 'package:uuid/uuid.dart';

class TaskComment {
  late String _id;
  final String content;
  final String? userPhotoUrl;
  final String userName;
  late DateTime _dateTime;

  TaskComment({
    String? id,
    required this.content,
    required this.userPhotoUrl,
    required this.userName,
    DateTime? dateTime,
  }) {
    _dateTime = dateTime ?? DateTime.now();
    _id = id ?? const Uuid().v4();
  }

  factory TaskComment.fromJson({required Map<String, dynamic> json}) {
    return TaskComment(
      id: json['id'],
      content: json['content'],
      userPhotoUrl: json['userPhotoUrl'],
      userName: json['userName'] == "null" ? null : json['userName'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  String toJson() {
    return '''
    {
      "id": "$_id",
      "content": "$content",
      "userPhotoUrl": "$userPhotoUrl",
      "userName": "$userName",
      "dateTime": "${_dateTime.toIso8601String()}"
    }
    ''';
  }

  String get id => _id;
  DateTime get dateTime => _dateTime;
}
