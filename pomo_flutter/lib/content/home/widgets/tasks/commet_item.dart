import 'package:PomoFlutter/content/home/models/task_comment.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/timer_controller.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommetItem extends StatelessWidget {
  const CommetItem({
    super.key,
    required this.comment,
    required this.mainController,
    required this.timerController,
  });

  final MainController mainController;
  final TimerController timerController;
  final TaskComment comment;

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
                    Text(
                      comment.userName,
                      style: MyTextStyles.p.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
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
