import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Generic repository interface
/// T: Entity type
/// ID: Entity ID type
/// IDC: Entity ID type for the collection
abstract class GenericRepository<T, ID, IDC> {
  Future<List<T>> findAll({required IDC idc});
  Future<T?> findById({required ID id, required IDC idc});
  Future<T?> save({required T entity, required IDC idc});
  Future<List<T>?> saveAll({required List<T> entities, required IDC idc});
  Future<void> deleteById({required ID id, required IDC idc});
  Future<void> delete({required T entity, required IDC idc});
  Future<void> deleteAllWhere({required List<ID> ids, required IDC idc});
  Future<void> deleteAll({required IDC idc});
  Future<bool> existsById({required ID id, required IDC idc});
  Future<bool> exists({required T entity, required IDC idc});
  Future<int> count({required IDC idc});

  StreamSubscription<DocumentSnapshot> addListener(
      {required IDC idc, required Function(List<T>) listener});
}
