import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/profile_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/my_button.dart';
import 'package:PomoFlutter/content/home/widgets/sliders_working_config.dart';
import 'package:PomoFlutter/content/home/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/my_icon_button.dart';
import '../widgets/welcome_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.authController,
    required this.mainController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "profile_title".tr,
      body: ListView(
        children: [
          const SizedBox(height: 15),
          WelcomeText(
            authController: authController,
            mainController: mainController,
          ),
          const SizedBox(height: 20),
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "default_working_config".tr,
                style: MyTextStyles.h2.textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SlidersWorkingConfig(
                countWorkingSession: profileController.countWorkingSession,
                onChangedCountWorkingSession: (value) {
                  profileController.countWorkingSession.value = value.round();
                },
                timeWorkingSession: profileController.timeWorkingSession,
                onChangedTimeWorkingSession: (value) {
                  profileController.timeWorkingSession.value = value.round();
                },
                timeBreakSession: profileController.timeBreakSession,
                onChangedTimeBreakSession: (value) {
                  profileController.timeBreakSession.value = value.round();
                },
                timeLongBreakSession: profileController.timeLongBreakSession,
                onChangedTimeLongBreakSession: (value) {
                  profileController.timeLongBreakSession.value = value.round();
                },
                spaceBetween: 15,
              ),
              const SizedBox(height: 20),
              //Button to save the configuration and reset values
              WrapInMid(
                child: Row(
                  children: [
                    Flexible(
                      child: MyButton(
                        onTap: () {
                          profileController.resetWorkingConfig();
                        },
                        color: MyColors.DANGER.color,
                        textColor: MyColors.LIGHT.color,
                        text: "reset_config".tr,
                        icon: Icons.restart_alt,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: MyButton(
                        onTap: () {
                          profileController.saveWorkingConfig();
                        },
                        color: MyColors.SUCCESS.color,
                        textColor: MyColors.LIGHT.color,
                        text: "save_config".tr,
                        icon: Icons.save,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "aparence_config".tr,
                style: MyTextStyles.h2.textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              WrapInMid(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyIconButton(
                      icon: Icons.brightness_4,
                      onTap: () {
                        profileController.changeTheme(mainController);
                      },
                      iconColor: MyColors.CONTRARY.color,
                      backgroundColor: MyColors.CURRENT.color,
                    ),
                    const SizedBox(width: 15),
                    MyIconButton(
                      icon: Icons.language,
                      onTap: () {
                        profileController.changeLanguage(mainController);
                      },
                      iconColor: MyColors.CONTRARY.color,
                      backgroundColor: MyColors.CURRENT.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "user_config".tr,
                style: MyTextStyles.h2.textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              WrapInMid(
                child: Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        onTap: () {
                          authController.signOut();
                        },
                        color: MyColors.DANGER.color,
                        textColor: MyColors.LIGHT.color,
                        text: "logout".tr,
                        icon: context.width > 600 ? null : Icons.logout,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
