import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onTap,
    this.text,
    this.icon,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final Function() onTap;
  final String? text;
  final IconData? icon;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: icon != null ? (text) : "",
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: icon == null
                  ? Text(
                      text!,
                      style: MyTextStyles.p.textStyle.copyWith(
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Icon(
                      icon,
                      color: textColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
