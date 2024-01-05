import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListItem extends StatelessWidget {
  const GuestListItem({
    super.key,
    required this.guest,
    required this.onDecline,
  });

  final String guest;
  final Function() onDecline;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    var color = MyColors.values[guest.hashCode % MyColors.values.length].color;
    return GenericContainer(
      color: MyColors.CURRENT.color,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.5)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          height: size,
          width: size,
          child: Icon(
            Icons.person,
            size: 25,
            color: MyColors.WARNING_EMPHSIS.color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              Text(
                guest,
                style: MyTextStyles.h3.textStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        MyIconButton(
          icon: Icons.delete,
          onTap: onDecline,
          iconColor: MyColors.DANGER.color,
          backgroundColor: MyColors.DANGER_EMPHSIS.color,
        ),
      ],
    );
  }
}
