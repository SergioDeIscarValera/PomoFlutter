import 'dart:async';
import 'dart:convert';

import 'package:PomoFlutter/models/id_user.dart';
import 'package:PomoFlutter/services/id_user/id_user_repository_firebase.dart';
import 'package:PomoFlutter/services/id_user/interface_id_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdUserRepository implements IIdUserRepository {
  static final IdUserRepository _singleton = IdUserRepository._internal();

  factory IdUserRepository() {
    return _singleton;
  }

  IdUserRepository._internal();

  final IIdUserRepositoryJson _idUserJsonRepository =
      IdUserRepositoryFirebase();
  @override
  StreamSubscription<DocumentSnapshot> addListener({
    required String idc,
    required Function(List<IdUser>) listener,
  }) {
    return _idUserJsonRepository.addListener(
        idc: idc,
        listener: (jsonList) {
          var taskList =
              jsonList.map((e) => IdUser.fromJson(json: jsonDecode(e)));
          listener(taskList.toList());
        });
  }

  @override
  Future<int> count({required String idc}) {
    return _idUserJsonRepository.count(idc: idc);
  }

  @override
  Future<void> delete({required IdUser entity, required String idc}) {
    return _idUserJsonRepository.delete(entity: entity.toJson(), idc: idc);
  }

  @override
  Future<void> deleteAll({required String idc}) {
    return _idUserJsonRepository.deleteAll(idc: idc);
  }

  @override
  Future<void> deleteAllWhere(
      {required List<String> ids, required String idc}) {
    return _idUserJsonRepository.deleteAllWhere(ids: ids, idc: idc);
  }

  @override
  Future<void> deleteById({required String id, required String idc}) {
    return _idUserJsonRepository.deleteById(id: id, idc: idc);
  }

  @override
  Future<bool> exists({required IdUser entity, required String idc}) {
    return _idUserJsonRepository.exists(entity: entity.toJson(), idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) {
    return _idUserJsonRepository.existsById(id: id, idc: idc);
  }

  @override
  Future<List<IdUser>> findAll({required String idc}) async {
    var result = await _idUserJsonRepository.findAll(idc: idc);
    return result.map((e) => IdUser.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<IdUser?> findById({required String id, required String idc}) async {
    var json = await _idUserJsonRepository.findById(id: id, idc: idc);
    if (json == null) {
      return null;
    }
    return IdUser.fromJson(json: jsonDecode(json));
  }

  @override
  Future<IdUser?> save({required IdUser entity, required String idc}) async {
    var result =
        await _idUserJsonRepository.save(entity: entity.toJson(), idc: idc);
    if (result == null) {
      return null;
    }
    return IdUser.fromJson(json: jsonDecode(result));
  }

  @override
  Future<List<IdUser>?> saveAll(
      {required List<IdUser> entities, required String idc}) async {
    var jsonList = entities.map((e) => e.toJson()).toList();
    var result =
        await _idUserJsonRepository.saveAll(entities: jsonList, idc: idc);
    if (result == null) {
      return null;
    }
    return result.map((e) => IdUser.fromJson(json: jsonDecode(e))).toList();
  }

  @override
  Future<bool> existEmail({required String email}) {
    return _idUserJsonRepository.existEmail(email: email);
  }
}
