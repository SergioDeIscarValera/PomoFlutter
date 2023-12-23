import 'package:PomoFlutter/content/home/models/task_comment.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.listCommets,
    required this.itemList,
  });

  final List<TaskComment> listCommets;
  final Widget Function(TaskComment) itemList;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (listCommets.isEmpty) {
        return Center(
          child: Text(
            "no_comments".tr,
            style: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.CONTRARY.color.withOpacity(0.8),
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }
      return ListView.builder(
        itemCount: listCommets.length,
        itemBuilder: (context, index) {
          return itemList(listCommets[index]);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );
    });
  }
}
