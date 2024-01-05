import 'dart:async';

import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:PomoFlutter/content/home/services/notification/interface_notication_repository.dart';
import 'package:PomoFlutter/content/home/services/notification/notification_repository.dart';
import 'package:PomoFlutter/content/home/services/task/task_repository.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/statistics_controller.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  final Rx<Task?> taskSelected = Rx<Task?>(null);
  StreamSubscription<DocumentSnapshot>? _taskListener;
  late String _taskListenerEmail;

  final RxDouble currentMax = 1.0.obs;
  final RxDouble current = 0.0.obs;
  final RxString currentFormatted = '00:00'.obs;
  final Rx<TimerStatus> timerStatus = TimerStatus.WORKING.obs;
  final RxBool isPlaying = false.obs;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _audioCache = AudioCache(prefix: "assets/sounds/");
  late final Uri urlKitchenTimer;
  int _lastTime = 0;

  final TaskRepository _taskRepository = TaskRepository();
  final AuthController _authController = Get.find();
  final StatisticsController _statisticsController = Get.find();
  final INotificationRepository _notificationRepository =
      NotificationRepository();

  late final Cronometro _cronometro = Cronometro(onTick: () {
    if (current.value >= currentMax.value) {
      _cronometro.pausar();
      //Play sound
      _playAlarmSound();
      if (timerStatus.value == TimerStatus.WORKING) {
        taskSelected.value?.addWorkSession();
        if (taskSelected.value?.isFinished ?? false) {
          saveTask(timeSpentInThisWorkSession: 0);
          _saveStatistics();
          if (taskSelected.value!.sheduleType != null) {
            _sheduleNextTask();
          }
          Get.back();
          return;
        }
      }
      _saveStatistics();
      taskSelected.value?.timerStatus = timerStatus.value == TimerStatus.WORKING
          ? TimerStatus.BREAK
          : TimerStatus.WORKING;
      taskSelected.refresh();
      saveTask(timeSpentInThisWorkSession: 0);
      current.value = 0;
      _lastTime = 0;
      isPlaying.value = false;
      return;
    }
    current.value++;
  });

  @override
  void onInit() {
    taskSelected.listen((task) {
      if (task == null && _taskListener != null) {
        if (_taskListenerEmail != _authController.firebaseUser!.email!) {
          //Para que actualice las tareas compartidas
          _refreshSharedTasks();
        }
        _taskListener?.cancel();
        _taskListener = null;
        return;
      }
      if (task != null && _taskListener == null) {
        _taskListenerEmail = task.amIPropietary
            ? _authController.firebaseUser!.email!
            : task.propietaryEmail!;
        _taskListener = _taskRepository.addListenerToSingleTask(
            idc: _taskListenerEmail,
            id: task.id,
            task: (newTask) {
              if (_taskListenerEmail != _authController.firebaseUser!.email!) {
                newTask.amIPropietary = false;
                newTask.propietaryEmail = _taskListenerEmail;
              }
              taskSelected.value = newTask;
            });
      }

      if (task?.timerStatus == TimerStatus.WORKING) {
        currentMax.value = (task?.workSessionTime.toDouble() ?? 1.0) * 60.0;
      } else if ((task?.workSessionsCompleted ?? 1.0) % 4 == 0) {
        currentMax.value = (task?.longBreakTime.toDouble() ?? 1.0) * 60.0;
      } else {
        currentMax.value = (task?.shortBreakTime.toDouble() ?? 1.0) * 60.0;
      }
      current.value = task?.timeSpent.toDouble() ?? 0.0;
      _lastTime = current.value.toInt();
      isPlaying.value = false;
      timerStatus.value = task?.timerStatus ?? TimerStatus.WORKING;
    });

    isPlaying.listen((value) {
      if (!value) {
        _cronometro.pausar();
        saveTask(timeSpentInThisWorkSession: current.value);
        // Add time to statistics
        _saveStatistics();
      } else {
        _lastTime = current.value.toInt();
        _cronometro.continuar();
      }
    });

    current.listen((value) {
      // 00:00 format
      currentFormatted.value = "${(value ~/ 60).toString().padLeft(2, '0')}:"
          "${(value % 60).toInt().toString().padLeft(2, '0')}";
    });

    _loadSounds();
    super.onInit();
  }

  void selectTask(Task task) {
    taskSelected.value = task;
  }

  void resetTimer() {
    current.value = 0;
    isPlaying.value = false;
    saveTask(timeSpentInThisWorkSession: 0);
  }

  void pauseChangeTimer() {
    isPlaying.value = !isPlaying.value;
  }

  void stopTimer(MainController mainController) {
    isPlaying.value = false;
    taskSelected.value?.timeSpent = current.value.toInt();
    saveTask(timeSpentInThisWorkSession: current.value);
    current.value = 0;
    mainController.setPage(0);
    Get.back();
  }

  void goBack(MainController mainController) {
    mainController.setPage(0);
    if (isPlaying.value) {
      saveTask(timeSpentInThisWorkSession: current.value, unselect: true);
      Get.back();
      MySnackBar.snackWarning("task_stopped".tr);
    } else {
      taskSelected.value = null;
      Get.back();
    }
  }

  void saveTask(
      {required double timeSpentInThisWorkSession,
      bool unselect = false}) async {
    taskSelected.value?.timeSpent = timeSpentInThisWorkSession.toInt();
    var email = taskSelected.value!.amIPropietary
        ? _authController.firebaseUser!.email!
        : taskSelected.value!.propietaryEmail!;
    await _taskRepository.save(
      entity: taskSelected.value!,
      idc: email,
    );
    if (unselect) {
      taskSelected.value = null;
    }
  }

  void _saveStatistics() {
    _statisticsController.addTime(
      timerStatus.value,
      taskSelected.value!.category,
      DateTime.now(),
      current.value.toInt() - _lastTime,
    );
  }

  void _playAlarmSound() {
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _audioPlayer.play(UrlSource(urlKitchenTimer.path), volume: 1.0);
  }

  void _loadSounds() async {
    urlKitchenTimer = await _audioCache.load("Kitchen-Timer-Alarm.mp3");
  }

  void _sheduleNextTask() async {
    var result = await _taskRepository.sheduleNextTask(
        task: taskSelected.value!, idc: _authController.firebaseUser!.email!);
    if (result == null) return;
    if (!result) {
      MySnackBar.snackError("error_shedule_next_task".tr);
    } else {
      MySnackBar.snackSuccess("success_shedule_next_task".tr);
    }
  }

  void _refreshSharedTasks() async {
    var total = await _notificationRepository.findAll(
        idc: _authController.firebaseUser!.email!);
    if (total.isEmpty) return;
    await _notificationRepository.save(
        entity: total[0], idc: _authController.firebaseUser!.email!);
  }
}

class Cronometro {
  Timer? _timer;
  bool _pausado = false;
  final Function() onTick;

  Cronometro({required this.onTick});

  void iniciar() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      //_timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      if (!_pausado) {
        onTick();
      }
    });
  }

  void pausar() {
    _pausado = true;
    _timer?.cancel();
  }

  void continuar() {
    _pausado = false;
    iniciar();
  }
}
