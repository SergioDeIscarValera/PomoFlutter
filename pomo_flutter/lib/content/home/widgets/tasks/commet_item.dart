import 'package:PomoFlutter/content/home/models/comment/task_check_list_item.dart';
import 'package:PomoFlutter/content/home/models/comment/task_comment.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommetItem extends StatelessWidget {
  const CommetItem({
    super.key,
    required this.comment,
    required this.mainController,
    required this.timerController,
    required this.onOpen,
    required this.onClose,
  });

  final MainController mainController;
  final TimerController timerController;
  final TaskComment comment;
  final Function() onOpen;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    var size = context.width < 500 ? 50.0 : 70.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onLongPress: () {
          mainController.deleteComment(
            timerController.taskSelected,
            comment,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: GenericContainer(
            color: MyColors.CURRENT.color,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      MyColors.CURRENT.color,
                      MyColors.CURRENT.color.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: size,
                width: size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    comment.userPhotoUrl ??
                        "https://i.postimg.cc/WzNTXrSJ/logo.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://i.postimg.cc/WzNTXrSJ/logo.png",
                        fit: BoxFit.cover,
                      );
                    },
                  ),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          comment.userName,
                          style: MyTextStyles.p.textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        if (comment.content is List<TaskCheckListItem>)
                          MyIconButton(
                            icon: Icons.add,
                            onTap: () {
                              mainController.addCheckListItem(
                                task: timerController.taskSelected.value!,
                                comment: comment,
                                onOpen: onOpen,
                                onClose: onClose,
                              );
                            },
                            iconColor: MyColors.LIGHT.color,
                            backgroundColor: MyColors.INFO.color,
                          ),
                      ],
                    ),
                    if (comment.content is String)
                      SelectableText(
                        comment.content,
                        style: MyTextStyles.p.textStyle.copyWith(
                          color: MyColors.CONTRARY.color.withOpacity(0.8),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                        //overflow: TextOverflow.ellipsis,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                      ),
                    if (comment.content is List<TaskCheckListItem>)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          for (TaskCheckListItem item in comment.content)
                            GestureDetector(
                              onLongPress: () {
                                mainController.removeCheckListItem(
                                  timerController.taskSelected.value!,
                                  comment,
                                  item,
                                );
                              },
                              child: GenericContainer(
                                margin: const EdgeInsets.only(bottom: 10),
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: item.isDone,
                                    onChanged: (value) {
                                      mainController.checkListItem(
                                        timerController.taskSelected.value!,
                                        comment,
                                        item,
                                        value!,
                                      );
                                    },
                                  ),
                                  SelectableText(
                                    item.content,
                                    style: MyTextStyles.p.textStyle.copyWith(
                                      color: MyColors.CONTRARY.color
                                          .withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.start,
                                    //overflow: TextOverflow.ellipsis,
                                    scrollPhysics:
                                        const NeverScrollableScrollPhysics(),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.yMMMd().format(comment.dateTime),
                      style: MyTextStyles.p.textStyle.copyWith(
                        color: MyColors.CONTRARY.color.withOpacity(0.3),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
