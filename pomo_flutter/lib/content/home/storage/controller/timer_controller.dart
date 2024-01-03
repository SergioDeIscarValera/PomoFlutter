import 'dart:async';

import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/statistics_controller.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  final Rx<Task?> taskSelected = Rx<Task?>(null);

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

  late final Cronometro _cronometro = Cronometro(onTick: () {
    if (current.value >= currentMax.value) {
      _cronometro.pausar();
      //Play sound
      _playAlarmSound();
      if (timerStatus.value == TimerStatus.WORKING) {
        taskSelected.value?.addWorkSession();
        if (taskSelected.value?.isFinished ?? false) {
          saveTask(0);
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
      saveTask(0);
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
        saveTask(current.value);
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
    saveTask(0);
  }

  void pauseChangeTimer() {
    isPlaying.value = !isPlaying.value;
  }

  void stopTimer(MainController mainController) {
    isPlaying.value = false;
    taskSelected.value?.timeSpent = current.value.toInt();
    saveTask(current.value);
    current.value = 0;
    mainController.setPage(0);
    Get.back();
  }

  void goBack(MainController mainController) {
    mainController.setPage(0);
    if (isPlaying.value) {
      saveTask(current.value);
      Get.back();
      MySnackBar.snackWarning("task_stopped".tr);
    } else {
      Get.back();
    }
  }

  void saveTask(double timeSpentInThisWorkSession) async {
    taskSelected.value?.timeSpent = timeSpentInThisWorkSession.toInt();
    _taskRepository.save(
        entity: taskSelected.value!, idc: _authController.firebaseUser!.email!);
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
