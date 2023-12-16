import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class GenericTemplate extends StatelessWidget {
  const GenericTemplate({
    Key? key,
    this.icon,
    required this.onIconTap,
    required this.title,
    required this.body,
  }) : super(key: key);

  final IconData? icon;
  final Function() onIconTap;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onIconTap,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 35,
                    )
                  : Image.asset(
                      "assets/images/logo.png",
                      height: 35,
                    ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: MyTextStyles.h1.textStyle,
            ),
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: body,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
