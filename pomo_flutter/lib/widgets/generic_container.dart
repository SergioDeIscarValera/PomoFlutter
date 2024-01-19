import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenericContainer extends StatelessWidget {
  const GenericContainer({
    super.key,
    required this.children,
    this.padding = 16,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.margin = const EdgeInsets.all(0),
    this.color,
  });

  final List<Widget> children;
  final double padding;
  final Axis direction;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? (Get.isDarkMode ? Colors.grey[800] : Colors.grey[300]),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(padding),
      child: Builder(
        builder: (context) {
          if (direction == Axis.horizontal) {
            return Row(
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            );
          }
        },
      ),
    );
  }
}
