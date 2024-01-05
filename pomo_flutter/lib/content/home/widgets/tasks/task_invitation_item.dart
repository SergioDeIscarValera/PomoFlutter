import 'package:PomoFlutter/content/home/models/task_invitation.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskInvitationItem extends StatelessWidget {
  const TaskInvitationItem({
    super.key,
    required this.noti,
    this.onAccept,
    required this.onDecline,
  });

  final TaskInvitation noti;
  final Function()? onAccept;
  final Function() onDecline;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    return GenericContainer(
      color: MyColors.CURRENT.color,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                noti.state ? MyColors.SUCCESS.color : MyColors.INFO.color,
                (noti.state ? MyColors.SUCCESS.color : MyColors.INFO.color)
                    .withOpacity(0.5)
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          height: size,
          width: size,
          child: Icon(
            noti.state ? Icons.done : Icons.notification_add,
            size: 25,
            color: MyColors.LIGHT.color,
          ),
        ),
        const SizedBox(width: 10),
        //Texts
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                noti.taskTitle,
                style: MyTextStyles.p.textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "from: ${noti.transmitterEmail}",
                style: MyTextStyles.p.textStyle.copyWith(
                  color: MyColors.CONTRARY.color.withOpacity(0.5),
                  fontSize: 14,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ],
          ),
        ),
        MyIconButton(
          icon: Icons.delete,
          onTap: onDecline,
          iconColor: MyColors.DANGER.color,
          backgroundColor: MyColors.DANGER_EMPHSIS.color,
        ),
        const SizedBox(width: 10),
        if (onAccept != null)
          MyIconButton(
            icon: Icons.done,
            onTap: onAccept!,
            iconColor: MyColors.SUCCESS.color,
            backgroundColor: MyColors.SUCCESS_EMPHSIS.color,
          ),
      ],
    );
  }
}
