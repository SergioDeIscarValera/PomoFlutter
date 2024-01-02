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
    required this.unit,
  }) : super(key: key);

  final String label;
  final int value;
  final Function(double) onChanged;
  final int min;
  final int max;
  final int divisions;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$label: $value $unit",
          style: MyTextStyles.p.textStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$min $unit",
              style: MyTextStyles.p.textStyle,
            ),
            Text(
              "$max $unit",
              style: MyTextStyles.p.textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Slider(
                value: value.toDouble(),
                onChanged: onChanged,
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: divisions,
                label: "$value $unit",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
