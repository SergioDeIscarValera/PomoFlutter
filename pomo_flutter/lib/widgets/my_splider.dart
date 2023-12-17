import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';

class MySplider extends StatelessWidget {
  const MySplider({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
  }) : super(key: key);

  final String label;
  final int value;
  final Function(double) onChanged;
  final double min;
  final double max;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$label: $value",
          style: MyTextStyles.p.textStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              min.toString(),
              style: MyTextStyles.p.textStyle,
            ),
            Expanded(
              child: Slider(
                value: value.toDouble(),
                onChanged: onChanged,
                min: min,
                max: max,
                divisions: divisions,
                label: value.toString(),
              ),
            ),
            Text(
              max.toString(),
              style: MyTextStyles.p.textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
