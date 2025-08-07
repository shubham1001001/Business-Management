import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/routes/app_routes_name.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/text_styles.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_outline_button.dart';
import '../../providers/item_create/item_create_provider.dart';
import '../pricing_preference/widgets/bottom_select_sheet_widget.dart';

class ItemCreateScreen extends StatelessWidget {
  const ItemCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(leadingWidth: 28, title: const Text("Create", style: AppTextStyles.appBarBlackText)),
      body: Consumer<ItemCreateProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppSpacing.smallHeight10,
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.extraSmallHeight,
                      Text(
                        "Select type",
                        style: AppTextStyles.greyBoldText.copyWith(color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800),
                      ),
                      AppSpacing.extraSmallHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildRadio("Product", true, provider),
                          const SizedBox(width: 25),
                          Padding(padding: const EdgeInsets.only(left: 20), child: _buildRadio("Service", false, provider)),
                        ],
                      ),
                      AppSpacing.mediumHeight16,
                      Text('Item name', style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                      AppSpacing.smallHeight10,
                      // Item Name
                      SizedBox(
                        child: CustomInputField(
                          controller: provider.itemNameController,
                          isEditable: true,
                          keyboardType: TextInputType.text,
                          hintText: 'Item name',
                          prefixText: "",
                          isRequired: true, //
                          errorText: provider.itemNameError,
                          onChanged: provider.validateForm,
                        ),
                      ),
                      AppSpacing.mediumHeight,
                      Text('Unit', style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                      AppSpacing.smallHeight10,

                      _buildSelectField(context, title: "Unit", value: provider.selectedUnit, options: provider.itemSelect, onSelected: (val) => provider.setSelectedUnit(val)),
                      // _buildSelectField(context, title: "Select unit", value: provider.unit, options: List.generate(8, (i) => "Unit ${i + 1}"), onSelected: provider.setUnit),
                      AppSpacing.mediumHeight,
                      Text('Sales account', style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, title: "", value: provider.selectedSalesAccount, options: provider.itemSelect, onSelected: (val) => provider.setSelectedSalesAccount(val)),
                      AppSpacing.mediumHeight,
                      Text('Purchase account', style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, title: "", value: provider.selectedPurchaseAccount, options: provider.itemSelect, onSelected: (val) => provider.setPurchaseAccount(val)),
                    ],
                  ),
                ),
                AppSpacing.largeHeight27,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutesName.pricingPreferenceScreen);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.add, color: AppColors.redColor, size: 26),
                        SizedBox(width: 3),
                        Text("Pricing preference", style: AppTextStyles.redBoldText14.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                AppSpacing.mediumWidth,
                AppSpacing.smallHeight10,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ItemCreateProvider>(
        builder: (context, provider, child) {
          return Container(
            color: Colors.white,
            padding: AppSpacing.allPadding16,
            child: Row(
              children: [
                Flexible(
                  child: CustomOutlinedButton(text: "Cancel", onPressed: () => Navigator.pop(context), borderColor: Colors.black, textColor: Colors.black, colors: Colors.white),
                ),
                AppSpacing.smallWidth10,
                Flexible(
                  child: CustomOutlinedButton(
                    colors: AppColors.redColor,
                    text: "Save",
                    onPressed: () {
                      if (provider.isValid) {
                        provider.submitForm();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item added successfully")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                      }
                    },
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRadio(String title, bool value, ItemCreateProvider provider) {
    return Row(
      children: [
        Radio<bool>(
          value: value,
          groupValue: provider.isProduct,
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.redColor;
            }
            return Colors.black;
          }),
          onChanged: (val) => provider.setType(val!),
        ),

        Text(
          title,
          style: AppTextStyles.greyBoldText.copyWith(color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _buildSelectField(BuildContext context, {required String title, required String? value, required List<String> options, required Function(String) onSelected}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          isScrollControlled: true,
          builder: (_) => BottomSelectSheetPricing(title: title, options: options, onSelect: onSelected, type: "Apply"),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(value ?? "Select $title", style: TextStyle(color: Colors.grey, fontSize: 16)),
      ),
    );
  }
}

// class _BottomSelectSheet extends StatelessWidget {
//   final String title;
//   final List<String> options;
//   final Function(String) onSelect;
//
//   const _BottomSelectSheet({required this.title, required this.options, required this.onSelect});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Consumer<ItemCreateProvider>(
//         builder: (context, provider, child) {
//           final provider = Provider.of<ItemCreateProvider>(context);
//           String? selected;
//
//           if (title == "Unit") {
//             selected = provider.selectedUnit;
//           } else if (title == "Sales account") {
//             selected = provider.selectedSalesAccount;
//           } else if (title == "Purchase account") {
//             selected = provider.selectedPurchaseAccount;
//           }
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.6,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title and Apply button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
//                       child: const Text("Apply"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//
//                 // Search bar
//                 TextField(
//                   decoration: InputDecoration(hintText: "Select $title here", prefixIcon: const Icon(Icons.search), border: const OutlineInputBorder()),
//                 ),
//                 const SizedBox(height: 10),
//
//                 // List of options
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: options.length,
//                     itemBuilder: (_, i) {
//                       final item = options[i];
//                       final isSelected = item == selected;
//
//                       return ListTile(
//                         title: Text(
//                           item,
//                           style: TextStyle(color: isSelected ? AppColors.redColor : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
//                         ),
//                         trailing: isSelected ? const Icon(Icons.check, color: AppColors.redColor) : null,
//                         onTap: () {
//                           if (title == "Unit") {
//                             provider.setSelectedUnit(item);
//                           } else if (title == "Sales account") {
//                             provider.setSelectedSalesAccount(item);
//                           } else if (title == "Purchase account") {
//                             provider.setSelectedPurchaseAccount(item);
//                           }
//                           onSelect(item); // optional callback
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
