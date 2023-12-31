import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarEventsDevice {
  static final CalendarEventsDevice _singleton =
      CalendarEventsDevice._internal();

  factory CalendarEventsDevice() {
    return _singleton;
  }

  CalendarEventsDevice._internal();

  Future<T?> checkCalendarPermissions<T>(
    Future<T?> Function() whenGranted,
  ) async {
    // Verificar si el permiso está concedido
    PermissionStatus permissionStatus =
        await Permission.calendarFullAccess.status;

    if (!permissionStatus.isGranted) {
      // Si el permiso no está concedido, solicitarlo al usuario
      if (permissionStatus.isPermanentlyDenied) {
        // Si es la primera vez que se solicita, pedir permiso al usuario
        permissionStatus = await Permission.calendarFullAccess.request();

        if (!permissionStatus.isGranted) {
          // Permiso denegado por el usuario, manejar según sea necesario
          // ...
          MySnackBar.snackError(
            "task_form_error_calendar_event_permission".tr,
          );
          return null;
        }
      } else {
        // El usuario negó los permisos, se puede redirigir a la configuración de la app
        // o mostrar un mensaje explicativo de cómo habilitar los permisos manualmente
        // ...
        openAppSettings();
        MySnackBar.snackError(
          "task_form_error_calendar_event_permission".tr,
        );
        return null;
      }
    }

    return whenGranted();
  }

  Future<Task?> addTaskDeviceCalendar({required Task task}) async {
    return await checkCalendarPermissions(() async {
      return await _addTaskDeviceCalendar(task: task);
    });
  }

  Future<Task?> _addTaskDeviceCalendar({required Task task}) async {
    // Obtener el calendario por defecto del dispositivo
    var deviceCalendarPlugin = await _getDeviceCalendarPlugin();
    if (deviceCalendarPlugin == null) {
      return null;
    }

    tz.Location location = tz.local;
    // Crear el evento en el calendario
    Event evento = Event(
      deviceCalendarPlugin.value,
      title: task.title,
      description: task.description,
      start: TZDateTime.from(task.dateTime, location),
      end: TZDateTime.from(task.endDateTime, location),
    );

    if (task.calendarId != "") {
      await deviceCalendarPlugin.key
          .deleteEvent(deviceCalendarPlugin.value, task.calendarId);
    }

    var createEventResult =
        await deviceCalendarPlugin.key.createOrUpdateEvent(evento);

    if (createEventResult?.isSuccess ?? false) {
      task.calendarId = createEventResult!.data!;
      MySnackBar.snackSuccess(
        "task_form_success_add_calendar_event".tr,
      );
      return task;
    } else {
      MySnackBar.snackError(
        "task_form_error_calendar_event".tr,
      );
      return null;
    }
  }

  Future<bool?> removeTaskByIdDeviceCalendar({required String id}) async {
    return await checkCalendarPermissions(() async {
      return await _removeTaskByIdDeviceCalendar(id: id);
    });
  }

  Future<bool> _removeTaskByIdDeviceCalendar({required String id}) async {
    // Obtener el calendario por defecto del dispositivo
    var deviceCalendarPlugin = await _getDeviceCalendarPlugin();
    if (deviceCalendarPlugin == null) {
      return false;
    }

    // Eliminar el evento del calendario
    var deleteEventResult = await deviceCalendarPlugin.key
        .deleteEvent(deviceCalendarPlugin.value, id);

    if (deleteEventResult.isSuccess) {
      MySnackBar.snackSuccess(
        "task_form_success_remove_calendar_event".tr,
      );
      return true;
    } else {
      MySnackBar.snackError(
        "task_form_error_calendar_event".tr,
      );
      return false;
    }
  }

  Future<bool?> removeTaskDeviceCalendar({required Task task}) async {
    return removeTaskByIdDeviceCalendar(id: task.calendarId);
  }

  Future<bool?> isTaskByIdInDeviceCalendar({required String id}) async {
    return await checkCalendarPermissions(() async {
      return await _isTaskByIdDeviceCalendar(id: id);
    });
  }

  Future<bool> _isTaskByIdDeviceCalendar({required String id}) async {
    // Obtener el calendario por defecto del dispositivo
    var deviceCalendarPlugin = await _getDeviceCalendarPlugin();
    if (deviceCalendarPlugin == null) {
      return false;
    }

    var now = DateTime.now();

    // Obtener el evento del calendario
    var retrieveEventsParams = RetrieveEventsParams(
      startDate: now.subtract(const Duration(days: 30)),
      endDate: now.add(const Duration(days: 30)),
    );
    var retrieveEventsResult = await deviceCalendarPlugin.key.retrieveEvents(
      deviceCalendarPlugin.value,
      retrieveEventsParams,
    );

    if (retrieveEventsResult.isSuccess) {
      return retrieveEventsResult.data?.any((event) => event.eventId == id) ??
          false;
    } else {
      return false;
    }
  }

  Future<bool?> isTaskInDeviceCalendar({required Task task}) async {
    return isTaskByIdInDeviceCalendar(id: task.id);
  }

  /// Retorna el plugin de calendario del dispositivo o null si no hay calendarios
  /// También retorna el id del calendario
  Future<MapEntry<DeviceCalendarPlugin, String>?>
      _getDeviceCalendarPlugin() async {
    DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
    var calendarResult = await deviceCalendarPlugin.retrieveCalendars();
    if (calendarResult.data?.isEmpty ?? true) {
      return null;
    }
    return MapEntry(deviceCalendarPlugin, calendarResult.data!.first.id!);
  }
}
