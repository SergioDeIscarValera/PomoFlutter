import 'package:PomoFlutter/widgets/rounded_decoration.dart';
import 'package:flutter/material.dart';

class DecorationDivider extends StatelessWidget {
  const DecorationDivider({
    super.key,
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedDecoration(
          color: color,
          backgroundColor: backgroundColor,
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: 2,
          ),
        ),
        RoundedDecoration(
          color: color,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
