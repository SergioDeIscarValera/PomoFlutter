import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendaryListItem extends StatelessWidget {
  const CalendaryListItem({
    super.key,
    required this.date,
    required this.onTap,
    required this.now,
    this.isSelect = false,
  });

  final DateTime date;
  final bool isSelect;
  final Function(DateTime) onTap;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    var isToday =
        now.day == date.day && now.month == date.month && now.year == date.year;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onTap(date);
        },
        child: GenericContainer(
          padding: context.width > 400 ? 16 : 8,
          color: isSelect
              ? MyColors.SUCCESS.color
              : isToday
                  ? MyColors.INFO.color
                  : null,
          direction: Axis.vertical,
          children: [
            Text(
              //First letter of the day
              DateFormat.E().format(date)[0],
              style: MyTextStyles.p.textStyle.copyWith(
                fontSize: context.width > 500 ? 20 : 16,
                color: isSelect || isToday
                    ? MyColors.LIGHT.color
                    : MyColors.CONTRARY.color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date.day.toString(),
              style: MyTextStyles.p.textStyle.copyWith(
                fontSize: context.width > 500 ? 20 : 16,
                color: isSelect || isToday
                    ? MyColors.LIGHT.color
                    : MyColors.CONTRARY.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
