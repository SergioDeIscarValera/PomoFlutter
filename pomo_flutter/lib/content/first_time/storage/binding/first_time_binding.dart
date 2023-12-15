import 'package:PomoFlutter/content/first_time/storage/controller/first_time_controller.dart';
import 'package:get/get.dart';

class FirstTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstTimeController>(() => FirstTimeController());
  }
}
