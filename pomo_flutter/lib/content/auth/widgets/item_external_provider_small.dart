import 'package:PomoFlutter/themes/colors.dart';
import 'package:flutter/material.dart';

class ItemExternalProviderSmall extends StatelessWidget {
  const ItemExternalProviderSmall(
      {Key? key, required this.image, required this.onPressed})
      : super(key: key);
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
          child: Image.asset(
            image,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
