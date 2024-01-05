import 'package:PomoFlutter/content/home/models/task_invitation.dart';
import 'package:PomoFlutter/services/interface_json_repository.dart';
import 'package:PomoFlutter/utils/generic_repository.dart';

abstract class INotificationRepository
    implements GenericRepository<TaskInvitation, String, String> {}

abstract class INotificationRepositoryJson extends IJsonRepository {}
