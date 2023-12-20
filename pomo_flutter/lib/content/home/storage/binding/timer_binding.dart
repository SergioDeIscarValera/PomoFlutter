import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:get/get.dart';

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerController>(() => TimerController());
  }
}
