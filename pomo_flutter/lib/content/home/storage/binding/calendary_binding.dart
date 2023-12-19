import 'package:PomoFlutter/content/home/storage/controller/calendary_controller.dart';
import 'package:get/get.dart';

class CalendaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendaryController>(() => CalendaryController());
  }
}
