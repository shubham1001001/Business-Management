import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_input_field.dart';
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
                    Text(title, style: AppTextStyles.appBlackTextW40018),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 34,
                        decoration: BoxDecoration(color: AppColors.redColor, borderRadius: AppSpacing.kMediumRadius),
                        child: const Text("Done", style: AppTextStyles.whiteBoldText14),
                      ),
                    ),
                  ],
                ),
                AppSpacing.mediumHeight16,

                // Search bar
                Container(
                  alignment: Alignment.center,
                  height: 47,
                  child: CustomInputField(isEditable: true, keyboardType: TextInputType.text, hintText: "Search ${title.toLowerCase()}", prefixText: "", isRequired: true, errorText: null, onChanged: (value) {}),
                ),
                AppSpacing.smallHeight10,
                Offstage(
                  offstage: title != "Vendor",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20, color: AppColors.redColor),
                      SizedBox(width: 4),
                      Text("Add a ${title.toLowerCase()}", style: AppTextStyles.appRedTextW60018),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 47,
                //   child: TextField(
                //     cursorColor: Colors.black,
                //     decoration: InputDecoration(
                //       hintStyle: AppTextStyles.greyText,
                //       hintText: "Select $title here",
                //       prefixIcon: const Icon(Icons.search),
                //       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: AppSpacing.kLargeRadius,
                //         borderSide: BorderSide(color: AppColors.textFieldBorderColor),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: AppSpacing.kLargeRadius,
                //         borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.5),
                //       ),
                //       border: OutlineInputBorder(borderRadius: AppSpacing.kLargeRadius),
                //       fillColor: Colors.white,
                //       filled: true,
                //     ),
                //   ),
                // ),
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
                          textAlign: TextAlign.start,
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
