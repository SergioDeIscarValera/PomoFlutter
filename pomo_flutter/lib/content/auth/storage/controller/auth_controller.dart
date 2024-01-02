import 'package:PomoFlutter/content/auth/errors/auth_errors.dart';
import 'package:PomoFlutter/content/auth/services/auth_firebase_repository.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool acceptTermsAndConditions = false.obs;

  final Rxn<User?> _firebaseUser = Rxn<User?>();
  User? get firebaseUser => _firebaseUser.value;
  set firebaseUser(User? newValue) => _firebaseUser.value = newValue;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onReady() {
    ever(_firebaseUser, handleAuthChanged);
    _firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(User? newUser) async {
    if (newUser == null || newUser.isAnonymous == true) {
      Get.offAllNamed(Routes.SPLASH.path);
      return;
    }
    var pageIsPolicy = Get.currentRoute == Routes.PRIVACY_POLICY.path
        ? 1
        : Get.currentRoute == Routes.DELETE_ACCOUNT.path
            ? 2
            : 0;
    if (newUser.emailVerified) {
      Get.offAllNamed(Routes.MAIN.path);
    } else {
      Get.offAllNamed(Routes.EMAIL_VERIFICATION.path);
    }
    if (pageIsPolicy != 0) {
      Get.offAllNamed(pageIsPolicy == 1
          ? Routes.PRIVACY_POLICY.path
          : Routes.DELETE_ACCOUNT.path);
    }
  }

  void loginWithEmailAndPassword() async {
    try {
      firebaseUser = await AuthFirebaseRepository().loginWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text);
      MySnackBar.snackSuccess("login_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void registerWithEmailAndPassword({
    required Function onSuccess,
  }) async {
    if (passwordController.value.text != confirmPasswordController.value.text) {
      MySnackBar.snackError("passwords_not_match".tr);
      return;
    }
    try {
      firebaseUser = await AuthFirebaseRepository()
          .registerWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
      onSuccess();
      MySnackBar.snackSuccess("register_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void loginWithGoogle() async {
    try {
      firebaseUser = await AuthFirebaseRepository().loginWithGoogle();
      MySnackBar.snackSuccess("login_google_success");
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
    firebaseUser = null;
  }

  void passwordReset() async {
    try {
      await AuthFirebaseRepository()
          .passwordReset(email: emailController.value.text);
      MySnackBar.snackSuccess("password_reset_send_success".tr);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }

  void removeUser() async {
    try {
      await AuthFirebaseRepository().removeUser();
      MySnackBar.snackSuccess("delete_account_success".tr);
      Get.offAllNamed(Routes.SPLASH.path);
    } on AuthErrors catch (e) {
      MySnackBar.snackError(e.message);
    } catch (e) {
      MySnackBar.snackError(e.toString());
    }
  }
}
