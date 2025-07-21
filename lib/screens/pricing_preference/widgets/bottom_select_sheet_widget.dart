import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/colors.dart';
import '../../../providers/pricing_preference/pricing_preference_provider.dart';

class BottomSelectSheetPricing extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;
  final provider;

  const BottomSelectSheetPricing({required this.title, required this.options, required this.onSelect, this.provider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Consumer<PricingPreferenceProvider>(
        builder: (context, provider, child) {
          final provider = Provider.of<PricingPreferenceProvider>(context);
          String? selected;
          selected = provider.selectedVendor;
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: AppSpacing.kMediumRadius10, color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Apply button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
                      child: const Text("Apply"),
                    ),
                  ],
                ),
                AppSpacing.smallHeight10,

                // Search bar
                TextField(
                  decoration: InputDecoration(hintText: "Select $title here", prefixIcon: const Icon(Icons.search), border: const OutlineInputBorder()),
                ),
                AppSpacing.smallHeight10,

                // List of options
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (_, i) {
                      final item = options[i];
                      final isSelected = item == selected;

                      return ListTile(
                        title: Text(
                          item,
                          style: TextStyle(color: isSelected ? AppColors.redColor : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                        ),
                        trailing: isSelected ? const Icon(Icons.check, color: AppColors.redColor) : null,
                        onTap: () {
                          provider.selectVendor(item);
                          onSelect(item); // optional callback
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
