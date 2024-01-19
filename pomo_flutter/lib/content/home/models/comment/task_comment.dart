import 'package:uuid/uuid.dart';

class TaskComment<T> {
  late String _id;
  final T content;
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

  factory TaskComment.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic) fromJson,
  }) {
    return TaskComment(
      id: json['id'],
      content: fromJson(json['content']),
      userPhotoUrl: json['userPhotoUrl'],
      userName: json['userName'] == "null" ? null : json['userName'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  String toJson() {
    var preJson = '''
    {
      "id": "$_id",
      "content": "$content",
      "userPhotoUrl": "$userPhotoUrl",
      "userName": "$userName",
      "dateTime": "${_dateTime.toIso8601String()}",
      "type": "${content.runtimeType}"
    }
    ''';

    if (content is! String) {
      //Remove " from the content value
      preJson = preJson.replaceAll('"$content"', "$content");
    }
    return preJson;
  }

  String get id => _id;
  DateTime get dateTime => _dateTime;
}
