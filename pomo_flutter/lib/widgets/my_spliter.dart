import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class MySpliter extends StatelessWidget {
  const MySpliter({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: MyColors.CONTRARY.color.withOpacity(0.5),
            height: 1,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ),
        Text(
          text,
          style: MyTextStyles.h3.textStyle.copyWith(
            color: MyColors.CONTRARY.color,
          ),
        ),
        Expanded(
          child: Divider(
            color: MyColors.CONTRARY.color.withOpacity(0.5),
            height: 1,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ),
      ],
    );
  }
}
