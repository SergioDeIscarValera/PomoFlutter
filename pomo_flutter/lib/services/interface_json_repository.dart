import 'package:PomoFlutter/utils/generic_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IJsonRepository
    implements GenericRepository<String, String, String> {
  Future<MapEntry<DocumentReference, DocumentSnapshot<Object?>?>>
      getRefAndSnapshot({required String idc});
}
