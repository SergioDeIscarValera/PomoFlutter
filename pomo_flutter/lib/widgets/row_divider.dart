import 'package:flutter/material.dart';

class RowDivider extends StatelessWidget {
  const RowDivider({
    Key? key,
    required this.bgColor,
    this.sideFlex = 1,
    this.mainFlex = 2,
    required this.child,
  }) : super(key: key);

  final int sideFlex;
  final int mainFlex;
  final Widget child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: sideFlex,
          child: Container(
            color: bgColor,
          ),
        ),
        Flexible(
          flex: mainFlex,
          child: child,
        ),
        Flexible(
          flex: sideFlex,
          child: Container(
            color: bgColor,
          ),
        ),
      ],
    );
  }
}
