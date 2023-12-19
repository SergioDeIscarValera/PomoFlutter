import 'package:flutter/material.dart';

class RoundedDecoration extends StatelessWidget {
  const RoundedDecoration({
    super.key,
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      height: 15,
      width: 15,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: 5,
          height: 5,
        ),
      ),
    );
  }
}
