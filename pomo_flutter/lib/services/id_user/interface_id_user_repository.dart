import 'package:PomoFlutter/models/id_user.dart';
import 'package:PomoFlutter/services/interface_json_repository.dart';
import 'package:PomoFlutter/utils/generic_repository.dart';

abstract class IIdUserRepository
    implements GenericRepository<IdUser, String, String> {
  Future<bool> existEmail({required String email});
}

abstract class IIdUserRepositoryJson extends IJsonRepository {
  Future<bool> existEmail({required String email});
}
