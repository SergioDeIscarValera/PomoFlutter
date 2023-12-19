import 'package:PomoFlutter/themes/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({
    super.key,
    required this.onTap,
    required this.pageIndex,
  });

  final RxInt pageIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CurvedNavigationBar(
        items: _generateIcons([
          Icons.home,
          Icons.calendar_month,
          Icons.add,
          Icons.leaderboard,
          Icons.person,
        ]),
        index: pageIndex.value,
        backgroundColor: MyColors.CURRENT.color,
        //backgroundColor: Colors.transparent,
        color: MyColors.PRIMARY.color,
        animationDuration: const Duration(milliseconds: 300),
        onTap: onTap,
      ),
    );
  }

  List<Widget> _generateIcons(List<IconData> list) {
    List<Widget> icons = [];
    for (var i = 0; i < list.length; i++) {
      icons.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Icon(
            list[i],
            color: pageIndex.value == i
                ? MyColors.LIGHT.color
                : MyColors.DARK.color,
          ),
        ),
      );
    }
    return icons;
  }
}
