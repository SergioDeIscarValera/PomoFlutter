import 'package:PomoFlutter/content/auth/storage/controller/email_verification_controller.dart';
import 'package:get/get.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
        () => EmailVerificationController());
  }
}
