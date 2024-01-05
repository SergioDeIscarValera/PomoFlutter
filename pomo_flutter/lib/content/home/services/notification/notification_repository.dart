import 'dart:async';
import 'dart:convert';

import 'package:PomoFlutter/content/home/models/task_invitation.dart';
import 'package:PomoFlutter/content/home/services/notification/interface_notication_repository.dart';
import 'package:PomoFlutter/content/home/services/notification/notification_repository_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepository implements INotificationRepository {
  static final NotificationRepository _singleton =
      NotificationRepository._internal();

  factory NotificationRepository() {
    return _singleton;
  }

  NotificationRepository._internal();

  final INotificationRepositoryJson _notificationJsonRepository =
      NotificationRepositoryFirebase();
  @override
  StreamSubscription<DocumentSnapshot> addListener(
      {required String idc,
      required Function(List<TaskInvitation> p1) listener}) {
    return _notificationJsonRepository.addListener(
        idc: idc,
        listener: (jsonList) {
          var notificationList =
              jsonList.map((e) => TaskInvitation.fromJson(json: jsonDecode(e)));
          listener(notificationList.toList());
        });
  }

  @override
  Future<int> count({required String idc}) {
    return _notificationJsonRepository.count(idc: idc);
  }

  @override
  Future<void> delete({required TaskInvitation entity, required String idc}) {
    return _notificationJsonRepository.delete(
        entity: entity.toJson(), idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) {
    return _notificationJsonRepository.deleteAll(idc: idc);
  }

  @override
  Future<void> deleteAllWhere(
      {required List<String> ids, required String idc}) {
    return _notificationJsonRepository.deleteAllWhere(ids: ids, idc: idc);
  }

  @override
  Future<void> deleteById({required String id, required String idc}) {
    return _notificationJsonRepository.deleteById(id: id, idc: idc);
  }

  @override
  Future<bool> exists({required TaskInvitation entity, required String idc}) {
    return _notificationJsonRepository.exists(
        entity: entity.toJson(), idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) {
    return _notificationJsonRepository.existsById(id: id, idc: idc);
  }

  @override
  Future<List<TaskInvitation>> findAll({required String idc}) async {
    var result = await _notificationJsonRepository.findAll(idc: idc);
    return result
        .map((e) => TaskInvitation.fromJson(json: jsonDecode(e)))
        .toList();
  }

  @override
  Future<TaskInvitation?> findById(
      {required String id, required String idc}) async {
    var json = await _notificationJsonRepository.findById(id: id, idc: idc);
    if (json == null) {
      return null;
    }
    return TaskInvitation.fromJson(json: jsonDecode(json));
  }

  @override
  Future<TaskInvitation?> save(
      {required TaskInvitation entity, required String idc}) async {
    var result = await _notificationJsonRepository.save(
        entity: entity.toJson(), idc: idc);
    if (result == null) {
      return null;
    }
    return TaskInvitation.fromJson(json: jsonDecode(result));
  }

  @override
  Future<List<TaskInvitation>?> saveAll(
      {required List<TaskInvitation> entities, required String idc}) async {
    var jsonList = entities.map((e) => e.toJson()).toList();
    var result =
        await _notificationJsonRepository.saveAll(entities: jsonList, idc: idc);
    if (result == null) {
      return null;
    }
    return result
        .map((e) => TaskInvitation.fromJson(json: jsonDecode(e)))
        .toList();
  }
}
