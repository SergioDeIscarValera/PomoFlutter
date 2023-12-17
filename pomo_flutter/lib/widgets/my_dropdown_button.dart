import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropdownButton<T> extends StatelessWidget {
  const MyDropdownButton({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
  });

  final void Function(T?) onChanged;
  final T value;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: DropdownButton(
        alignment: Alignment.center,
        isExpanded: true,
        iconEnabledColor: MyColors.PRIMARY.color,
        value: value,
        borderRadius: BorderRadius.circular(24),
        dropdownColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
        menuMaxHeight: 400,
        onChanged: onChanged,
        style: MyTextStyles.p.textStyle,
        underline: const SizedBox(),
        items: items,
      ),
    );
  }
}
