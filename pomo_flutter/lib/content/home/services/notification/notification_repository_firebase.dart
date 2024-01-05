import 'dart:async';
import 'dart:convert';

import 'package:PomoFlutter/content/home/services/notification/interface_notication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepositoryFirebase implements INotificationRepositoryJson {
  static final NotificationRepositoryFirebase _singleton =
      NotificationRepositoryFirebase._internal();

  factory NotificationRepositoryFirebase() {
    return _singleton;
  }

  NotificationRepositoryFirebase._internal();

  static const String _collection = "notifications";
  static const String _notificationList = "notifications";

  @override
  Future<MapEntry<DocumentReference<Object?>, DocumentSnapshot<Object?>?>>
      getRefAndSnapshot({required String idc}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(_collection).doc(idc);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error getting notifications of $idc from $_collection");
    }
  }

  @override
  StreamSubscription<DocumentSnapshot> addListener({
    required String idc,
    required Function(List<String>) listener,
  }) {
    return FirebaseFirestore.instance
        .collection(_collection)
        .doc(idc)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (!snapshot.exists) return;
      var data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || data[_notificationList] == null) return;
      listener((data[_notificationList] as List<dynamic>)
          .map((e) => jsonEncode(e))
          .toList());
    });
  }

  @override
  Future<int> count({required String idc}) async {
    return (await findAll(idc: idc)).length;
  }

  @override
  Future<void> delete({required String entity, required String idc}) {
    return deleteById(id: jsonDecode(entity)["id"], idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return;
    }
    docRef.key.delete();
  }

  @override
  Future<void> deleteAllWhere({
    required List<String> ids,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return;
    }
    List<dynamic> updatedList =
        (docRef.value![_notificationList] as List<dynamic>)
            .where((notification) => !ids.contains(notification['id']))
            .toList();

    docRef.key.update({_notificationList: updatedList});
  }

  @override
  Future<void> deleteById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return;
    }
    // Filter where id is in the list and remove it
    List<dynamic> updatedList =
        (docRef.value![_notificationList] as List<dynamic>)
            .where((task) => task['id'] != id)
            .toList();

    docRef.key.update({_notificationList: updatedList});
  }

  @override
  Future<bool> exists({required String entity, required String idc}) {
    return existsById(id: jsonDecode(entity)["id"], idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return false;
    }
    var data = docRef.value!.data() as Map<String, dynamic>?;
    if (data == null || data[_notificationList] == null) return false;
    return (data[_notificationList] as List<dynamic>)
        .any((notification) => notification['id'] == id);
  }

  @override
  Future<List<String>> findAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return [];
    }
    var snapshot = docRef.value!;
    if (!snapshot.exists) return [];
    var data = snapshot.data() as Map<String, dynamic>?;
    if (data == null || data[_notificationList] == null) return [];
    return (data[_notificationList] as List<dynamic>)
        .map((e) => jsonEncode(e))
        .toList();
  }

  @override
  Future<String?> findById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return null;
    }
    return docRef.value![_notificationList][id];
  }

  @override
  Future<String?> save({required String entity, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    var json = jsonDecode(entity);
    if (docRef.value == null) {
      docRef.key.set({
        _notificationList: [json]
      });
    } else {
      var currentNotification =
          (docRef.value![_notificationList] as List<dynamic>);
      var existingNotificationIndex = currentNotification.indexWhere(
        (notification) => notification['id'] == json['id'],
      );
      if (existingNotificationIndex != -1) {
        // Update the existing notification if found
        currentNotification[existingNotificationIndex] = json;
        docRef.key.update({
          _notificationList: currentNotification,
        });
      } else {
        // Add the notification if not found
        docRef.key.update({
          _notificationList: FieldValue.arrayUnion([json])
        });
      }
    }
    return entity;
  }

  @override
  Future<List<String>?> saveAll({
    required List<String> entities,
    required String idc,
  }) async {
    for (var entity in entities) {
      var result = await save(entity: entity, idc: idc);
      if (result == null) {
        return null;
      }
    }
    return entities;
  }
}
/*
id -> transmitterEmail + ___ + taskIdTrasmitter
{
  "notifications": [
    {
      "id": "email@email.com___fe0c54cc-2d2a-4eb9-b6b0-b9b8c1d6c0a0",
      "taskTitle": "Task 1",
      "state": false,
      "dateTime": "2021-07-18T18:00:00.000Z"
    },
    {
      "id": "email2@email.com___752387da-96ae-46f3-b44c-6d8ade1c346a",
      "taskTitle": "Task 2",
      "state": true,
      "dateTime": "2021-07-20T18:00:00.000Z"
    }
  ]
}
*/