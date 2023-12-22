import 'dart:convert';

import 'package:PomoFlutter/content/home/services/interface_daily_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyDataRepositoryFirebase implements IDailyDataJsonRepository {
  static final DailyDataRepositoryFirebase _singleton =
      DailyDataRepositoryFirebase._internal();

  factory DailyDataRepositoryFirebase() {
    return _singleton;
  }

  DailyDataRepositoryFirebase._internal();

  static const String _collection = "dailyData";
  static const String _taskList = "dailyData";

  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      _getRefAndSnapshot({required String email}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(_collection).doc(email);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error getting user data of $email from $_collection");
    }
  }

  @override
  void addListener(
      {required String idc, required Function(List<String> p1) listener}) {
    FirebaseFirestore.instance
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
  Future<int> count({required String idc}) async {
    return (await findAll(idc: idc)).length;
  }

  @override
  Future<void> delete({required String entity, required String idc}) async {
    return await deleteById(id: jsonDecode(entity)["date"], idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return;
    }
    docRef.key.delete();
  }

  @override
  Future<void> deleteAllWhere(
      {required List<String> ids, required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return;
    }
    List<dynamic> updatedList = (docRef.value![_taskList] as List<dynamic>)
        .where((task) => !ids.contains(task['date']))
        .toList();

    docRef.key.update({_taskList: updatedList});
  }

  @override
  Future<void> deleteById({required String id, required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return;
    }
    // Filter where id is in the list and remove it
    List<dynamic> updatedList = (docRef.value![_taskList] as List<dynamic>)
        .where((task) => task['date'] != id)
        .toList();

    docRef.key.update({_taskList: updatedList});
  }

  @override
  Future<bool> exists({required String entity, required String idc}) async {
    return await existsById(id: jsonDecode(entity)["date"], idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return false;
    }
    return docRef.value![_taskList].contains(id);
  }

  @override
  Future<List<String>> findAll({required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return [];
    }
    return _findAllUsingSnapshot(docRef.value!);
  }

  @override
  Future<String?> findById({required String id, required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    if (docRef.value == null) {
      return null;
    }
    return docRef.value![_taskList][id];
  }

  @override
  Future<String?> save({required String entity, required String idc}) async {
    var docRef = await _getRefAndSnapshot(email: idc);
    var json = jsonDecode(entity);
    if (docRef.value == null) {
      docRef.key.set({
        _taskList: [json]
      });
    } else {
      var currentTasks = (docRef.value![_taskList] as List<dynamic>);
      var existingTaskIndex = currentTasks.indexWhere(
        (task) => task['date'] == json['date'],
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
  Future<List<String>?> saveAll(
      {required List<String> entities, required String idc}) async {
    for (var entity in entities) {
      var result = await save(entity: entity, idc: idc);
      if (result == null) {
        return null;
      }
    }
    return Future.value(entities);
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
