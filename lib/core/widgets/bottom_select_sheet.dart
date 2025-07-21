import 'package:flutter/material.dart';

class BottomSelectSheet extends StatelessWidget {
  final List<String> items;
  final void Function(String) onSelect;

  const BottomSelectSheet({required this.items, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          return ListTile(title: Text(items[index]), onTap: () => onSelect(items[index]));
        },
      ),
    );
  }
}
