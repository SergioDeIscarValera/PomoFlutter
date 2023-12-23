import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/utils/storage_keys.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final RxInt countWorkingSession = 1.obs;
  final RxInt timeWorkingSession = 25.obs;
  final RxInt timeBreakSession = 5.obs;
  final RxInt timeLongBreakSession = 15.obs;

  final box = GetStorage();

  @override
  void onInit() {
    resetWorkingConfig();
    super.onInit();
  }

  void saveWorkingConfig() {
    if (GetPlatform.isWeb) {
      MySnackBar.snackError("error_save_config_web".tr);
    } else {
      _saveConfig();
    }
  }

  void resetWorkingConfig() {
    //Load config from storage if is mobile
    if (GetPlatform.isWeb) {
      _defaultConfig();
    } else {
      _loadFromStorage();
    }
  }

  void _defaultConfig() {
    countWorkingSession.value = 1;
    timeWorkingSession.value = 25;
    timeBreakSession.value = 5;
    timeLongBreakSession.value = 15;
  }

  void _loadFromStorage() {
    countWorkingSession.value =
        box.read(StorageKeys().countWorkingSession) ?? 1;
    timeWorkingSession.value = box.read(StorageKeys().timeWorkingSession) ?? 25;
    timeBreakSession.value = box.read(StorageKeys().timeBreakSession) ?? 5;
    timeLongBreakSession.value =
        box.read(StorageKeys().timeLongBreakSession) ?? 15;
  }

  void _saveConfig() {
    box.write(StorageKeys().countWorkingSession, countWorkingSession.value);
    box.write(StorageKeys().timeWorkingSession, timeWorkingSession.value);
    box.write(StorageKeys().timeBreakSession, timeBreakSession.value);
    box.write(StorageKeys().timeLongBreakSession, timeLongBreakSession.value);
    MySnackBar.snackSuccess("success_save_config".tr);
  }

  void changeTheme(MainController mainController) async {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    if (!GetPlatform.isWeb) {
      await box.write(StorageKeys().themeMode, !Get.isDarkMode);
    }
    await Future.delayed(const Duration(milliseconds: 150));
    Get.updateLocale(
      Get.locale == const Locale("en", "US")
          ? const Locale("en", "US")
          : const Locale("es", "ES"),
    );
    await Future.delayed(const Duration(milliseconds: 150));
    mainController.setPage(4);
  }

  void changeLanguage(MainController mainController) async {
    Get.updateLocale(
      Get.locale == const Locale("en", "US")
          ? const Locale("es", "ES")
          : const Locale("en", "US"),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    mainController.setPage(4);
  }
}
