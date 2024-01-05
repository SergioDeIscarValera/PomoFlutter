import 'package:uuid/uuid.dart';

class IdUser {
  late String _id;
  final String email;

  IdUser({
    String? id,
    required this.email,
  }) {
    _id = id ?? const Uuid().v4();
  }

  String get id => _id;

  factory IdUser.fromJson({required Map<String, dynamic> json}) {
    return IdUser(
      id: json['idUser'],
      email: json['email'],
    );
  }

  String toJson() {
    return """
    {
      "idUser": "$id",
      "email": "$email"
    }
    """;
  }
}
