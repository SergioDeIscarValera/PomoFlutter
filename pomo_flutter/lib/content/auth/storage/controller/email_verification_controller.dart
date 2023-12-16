import 'dart:async';

import 'package:PomoFlutter/content/auth/errors/auth_errors.dart';
import 'package:PomoFlutter/content/auth/services/auth_firebase_repository.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  RxBool isHoverResendButton = false.obs;
  RxBool isHoverLoginButton = false.obs;

  @override
  void onReady() {
    sendVerificationEmail();
    setTimerForRedirect();
    super.onReady();
  }

  void sendVerificationEmail() async {
    try {
      await AuthFirebaseRepository().sendVerificationEmail();
      MySnackBar.snackSuccess("verification_email_sent".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void setTimerForRedirect() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerificationStatus(timer: timer);
    });
  }

  void manualyCheckEmailVerificationStatus() {
    checkEmailVerificationStatus();
  }

  void checkEmailVerificationStatus({Timer? timer}) {
    FirebaseAuth.instance.currentUser!.reload();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      timer?.cancel();
      MySnackBar.snackSuccess("email_verified".tr);
      Get.offAllNamed(Routes.MAIN.path);
    }
  }
}
