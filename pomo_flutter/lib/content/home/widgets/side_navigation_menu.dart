import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideNavigationMenu extends StatelessWidget {
  const SideNavigationMenu({
    Key? key,
    required this.scaffoldKey,
    required this.mainController,
    required this.pageIndex,
  }) : super(key: key);

  final RxInt pageIndex;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0.5, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ..._generateIcons(
              [
                Icons.home,
                Icons.add,
                Icons.leaderboard,
                Icons.person,
              ],
              [
                "app_name".tr,
                "task_form_title".tr,
                "statics_title".tr,
                "profile_title".tr,
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateIcons(List<IconData> list, List<String> text) {
    List<Widget> icons = [];
    for (var i = 0; i < list.length; i++) {
      icons.add(
        ListTile(
          leading: Icon(
            list[i],
            color: pageIndex.value == i
                ? MyColors.PRIMARY.color
                : MyColors.CONTRARY.color,
          ),
          title: Text(
            text[i],
            style: TextStyle(
              color: pageIndex.value == i
                  ? MyColors.PRIMARY.color
                  : MyColors.CONTRARY.color,
            ),
          ),
          onTap: () {
            mainController.setPage(i);
            scaffoldKey.currentState!.openEndDrawer();
          },
        ),
      );
    }
    return icons;
  }
}
