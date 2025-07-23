import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final isExpanded;
  final hint;

  const CustomDropdown({super.key, required this.value, required this.items, required this.onChanged, this.isExpanded, this.hint});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      hint: hint,
      icon: Icon(Icons.keyboard_arrow_down),
      isDense: false,
      isExpanded: isExpanded,
      underline: const SizedBox(),
      value: value, //
      items: items,
      onChanged: onChanged,
    );
  }
}
