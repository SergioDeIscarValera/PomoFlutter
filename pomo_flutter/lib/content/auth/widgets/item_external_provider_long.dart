import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class ItemExternalProviderLong extends StatelessWidget {
  const ItemExternalProviderLong({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
  });

  final String text;
  final String image;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.CONTRARY.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColors.CONTRARY.color.withOpacity(0.5),
              width: 2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                image,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: MyTextStyles.h3.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
