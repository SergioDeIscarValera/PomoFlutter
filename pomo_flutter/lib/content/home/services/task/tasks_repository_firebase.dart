import 'dart:async';
import 'dart:convert';
import 'package:PomoFlutter/content/home/services/task/interface_task_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepositoryFirebase implements ITaskRepositoryJson {
  static final TaskRepositoryFirebase _singleton =
      TaskRepositoryFirebase._internal();

  factory TaskRepositoryFirebase() {
    return _singleton;
  }

  TaskRepositoryFirebase._internal();

  static const String _collection = "tasks";
  static const String _taskList = "tasks";

  @override
  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      getRefAndSnapshot({required String idc}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(_collection).doc(idc);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error getting user data of $idc from $_collection");
    }
  }

  @override
  Future<int> count({required String idc}) async {
    return (await findAll(idc: idc)).length;
  }

  @override
  Future<void> delete({required String entity, required String idc}) async {
    return await deleteById(id: jsonDecode(entity)["id"], idc: idc);
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
  Future<void> deleteById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return;
    }
    // Filter where id is in the list and remove it
    List<dynamic> updatedList = (docRef.value![_taskList] as List<dynamic>)
        .where((task) => task['id'] != id)
        .toList();

    docRef.key.update({_taskList: updatedList});
  }

  @override
  Future<void> deleteAllWhere(
      {required List<String> ids, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return;
    }
    List<dynamic> updatedList = (docRef.value![_taskList] as List<dynamic>)
        .where((task) => !ids.contains(task['id']))
        .toList();

    docRef.key.update({_taskList: updatedList});
  }

  @override
  Future<bool> exists({required String entity, required String idc}) async {
    return await existsById(id: jsonDecode(entity)["id"], idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return false;
    }
    return docRef.value![_taskList].contains(id);
  }

  @override
  Future<List<String>> findAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return [];
    }
    return _findAllUsingSnapshot(docRef.value!);
  }

  @override
  Future<String?> findById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) return null;

    var data = docRef.value!.data() as Map<String, dynamic>?;

    if (data == null || data[_taskList] == null) return null;

    var task = (data[_taskList] as List<dynamic>)
        .firstWhere((task) => task['id'] == id, orElse: () => null);
    return task == null ? null : jsonEncode(task);
  }

  @override
  Future<String?> save({required String entity, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    var json = jsonDecode(entity);
    if (docRef.value == null) {
      docRef.key.set({
        _taskList: [json]
      });
    } else {
      var currentTasks = (docRef.value![_taskList] as List<dynamic>);
      var existingTaskIndex = currentTasks.indexWhere(
        (task) => task['id'] == json['id'],
      );
      if (existingTaskIndex != -1) {
        // Update the existing task if found
        currentTasks[existingTaskIndex] = json;
        docRef.key.update({
          _taskList: currentTasks,
        });
      } else {
        // Add the task if not found
        docRef.key.update({
          _taskList: FieldValue.arrayUnion([json])
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
      if (data == null || data[_taskList] == null) return;
      listener((data[_taskList] as List<dynamic>)
          .map((e) => jsonEncode(e))
          .toList());
    });
  }

  @override
  StreamSubscription<DocumentSnapshot> addListenerToSingleTask({
    required String idc,
    required String id,
    required Function(String) listenear,
  }) {
    return FirebaseFirestore.instance
        .collection(_collection)
        .doc(idc)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (!snapshot.exists) return;
      var data = snapshot.data() as Map<String, dynamic>?;
      if (data == null || data[_taskList] == null) return;
      var task = (data[_taskList] as List<dynamic>)
          .firstWhere((task) => task['id'] == id, orElse: () => null);
      if (task == null) return;
      listenear(jsonEncode(task));
    });
  }

  List<String> _findAllUsingSnapshot(DocumentSnapshot snapshot) {
    if (!snapshot.exists) return [];
    var data = snapshot.data() as Map<String, dynamic>?;
    if (data == null || data[_taskList] == null) return [];
    return (data[_taskList] as List<dynamic>)
        .map((e) => jsonEncode(e))
        .toList();
  }
}

/*
{
  "tasks": [
    {
      "id": "074dffd2-ffc0-49f8-98f6-10c6b969b53c",
      "title": "Task 1",
      "description": "Description 1",
      "dateTime": "2021-08-01T00:00:00.000Z",
      "category": "work",
      "color": "red",
      "workSessions": 4,
      "workSessionTime": 25,
      "longBreakTime": 15,
      "shortBreakTime": 5,
      "comments":[
        {
          "content": "bla bla bla",
          "dateTime": "2024-01-01T00:00:00.000Z",
          "id": "074dffd2-ffc0-49f8-98f6-10c6b969b999",
          "userName": "user1",
          "userPhotoUrl": "https://www.google.com",
        },
      ],
      "endDateTime": "2021-08-01T00:00:00.000Z",
      "calendarId": "84"
    },
    {
      "id": "074dffd2-ffc0-49f8-98f6-10c6b969b54c",
      "title": "Task 2",
      "description": "Description 2",
      "dateTime": "2021-08-01T00:00:00.000Z",
      "category": "work",
      "color": "blue",
      "workSessions": 4,
      "workSessionTime": 25,
      "longBreakTime": 15,
      "shortBreakTime": 5,
    },
    {
      "id": "074dffd2-ffc0-49f8-98f6-10c6b969b55c",
      "title": "Task 3",
      "description": "Description 3",
      "dateTime": "2021-08-01T00:00:00.000Z",
      "category": "work",
      "color": "green",
      "workSessions": 4,
      "workSessionTime": 25,
      "longBreakTime": 15,
      "shortBreakTime": 5,
    },
  ],
}
*/
