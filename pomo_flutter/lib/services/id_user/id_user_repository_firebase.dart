import 'dart:async';
import 'dart:convert';
import 'package:PomoFlutter/services/id_user/interface_id_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdUserRepositoryFirebase implements IIdUserRepositoryJson {
  static final IdUserRepositoryFirebase _singleton =
      IdUserRepositoryFirebase._internal();

  factory IdUserRepositoryFirebase() {
    return _singleton;
  }

  IdUserRepositoryFirebase._internal();

  static const String _collection = "idUsers";
  static const String _userEmail = "email"; // Element of the collection

  @override
  Future<MapEntry<DocumentReference<Object?>, DocumentSnapshot<Object?>?>>
      getRefAndSnapshot({required String idc}) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection(_collection).doc(idc);
      DocumentSnapshot<Object?> snapshot = await docRef.get();
      return MapEntry(docRef, snapshot.exists ? snapshot : null);
    } catch (e) {
      throw Exception("Error getting id user of $idc from $_collection");
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
      if (data == null || data[_userEmail] == null) return;
      // En este caso no hay lista por lo que encapsulamos un unico elemento
      listener([jsonEncode(data)]);
    });
  }

  @override
  Future<int> count({required String idc}) async {
    return (await findAll(idc: idc)).length;
  }

  @override
  Future<void> delete({required String entity, required String idc}) {
    return deleteById(id: jsonDecode(entity)[_userEmail], idc: idc);
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
  Future<void> deleteAllWhere(
      {required List<String> ids, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null || ids.isEmpty || ids.length > 1) {
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
    docRef.key.delete();
  }

  @override
  Future<bool> exists({required String entity, required String idc}) {
    return existsById(id: jsonDecode(entity)[_userEmail], idc: idc);
  }

  @override
  Future<bool> existsById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return false;
    }
    var resutl = (docRef.value![_userEmail] as String) == id;
    return resutl;
  }

  @override
  Future<List<String>> findAll({required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return [];
    }
    return [jsonEncode(docRef.value)];
  }

  @override
  Future<String?> findById({required String id, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (docRef.value == null) {
      return null;
    }
    return jsonEncode(docRef.value);
  }

  @override
  Future<String?> save({required String entity, required String idc}) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    var json = jsonDecode(entity);
    if (docRef.value == null) {
      docRef.key.set(json);
    } else {
      docRef.key.update(json);
    }

    return entity;
  }

  @override
  Future<List<String>?> saveAll(
      {required List<String> entities, required String idc}) async {
    if (entities.isEmpty || entities.length > 1) {
      return null;
    }
    var result = await save(entity: entities.first, idc: idc);

    return result == null ? null : [result];
  }

  @override
  Future<bool> existEmail({required String email}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(_collection);

    QuerySnapshot querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.isEmpty) return false;
    List<String> documentIDs = querySnapshot.docs.map((doc) => doc.id).toList();
    return documentIDs.contains(email);
  }
}
/*
{
  "idUser": "4bc9b84c-1ace-40dd-a86a-4d449288a6f1",
  "email": "email@email.com",
}
*/
