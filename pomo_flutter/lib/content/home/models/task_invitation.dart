class TaskInvitation {
  final String taskIdTrasmitter;
  final String transmitterEmail;
  final String taskTitle;
  bool state;
  final DateTime dateTime;

  /// [state] false -> pending, true -> accepted
  TaskInvitation({
    required this.taskIdTrasmitter,
    required this.transmitterEmail,
    required this.taskTitle,
    required this.dateTime,
    this.state = false,
  });

  String get id => "${transmitterEmail}___$taskIdTrasmitter";

  factory TaskInvitation.fromJson({required Map<String, dynamic> json}) {
    var ids = json['id'].split("___");
    return TaskInvitation(
      taskIdTrasmitter: ids[1],
      transmitterEmail: ids[0],
      taskTitle: json['taskTitle'],
      state: json['state'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  String toJson() {
    return """
      {
        "id": "$id",
        "taskTitle": "$taskTitle",
        "state": $state,
        "dateTime": "${dateTime.toIso8601String()}"
      }
    """;
  }
}
