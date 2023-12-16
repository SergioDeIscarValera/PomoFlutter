import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/pages/statistics_page.dart';
import 'package:PomoFlutter/content/home/pages/task_form_page.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/my_bottom_navigation.dart';
import 'package:PomoFlutter/content/home/widgets/side_navigation_menu.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    MainController homeController = Get.find();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: MainBody(
            mainController: homeController,
            authController: authController,
          ),
          tablet: MainBody(
            mainController: homeController,
            authController: authController,
          ),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: SideNavigationMenu(
                  scaffoldKey: scaffoldKey,
                  mainController: homeController,
                  pageIndex: homeController.pageIndex,
                ),
              ),
              const SizedBox(width: 30),
              Flexible(
                flex: 3,
                child: MainBody(
                  mainController: homeController,
                  authController: authController,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: context.width < 500
          ? MyBottomNavigation(
              pageIndex: homeController.pageIndex,
              onTap: homeController.setPage,
            )
          : null,
      drawer: context.width >= 500 && context.width < 1100
          ? Drawer(
              child: SideNavigationMenu(
                scaffoldKey: scaffoldKey,
                mainController: homeController,
                pageIndex: homeController.pageIndex,
              ),
            )
          : null,
      floatingActionButton: context.width >= 500 && context.width < 1100
          ? FloatingActionButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.mainController,
    required this.authController,
  }) : super(key: key);

  final AuthController authController;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: mainController.mainPageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomePage(
          authController: authController,
          mainController: mainController,
        ),
        TaskFormPage(
          mainController: mainController,
        ),
        StatisticsPage(
          mainController: mainController,
        ),
        GenericTemplate(
          onIconTap: () {
            mainController.setPage(0);
          },
          title: "profile_title".tr,
          body: Container(
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}