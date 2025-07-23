import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_date_picker.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_outline_button.dart';
import '../../providers/add_purchase/add_purchase_provider.dart';
import '../pricing_preference/widgets/bottom_select_sheet_widget.dart';

class AddPurchaseScreen extends StatelessWidget {
  const AddPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Purchase")),
      body: Consumer<AddPurchaseProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: AppSpacing.allPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg", size: 20.0),
                          AppSpacing.extraSmallWidth,
                          Text("12.02.2025", style: AppTextStyles.appRedText),
                        ],
                      ),
                      Text("Vendor name", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, " Vendor", provider.selectedVendorName, provider.owners, provider.setVendorName),

                      AppSpacing.smallHeight10,
                      Text("Mobile number", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.mobileNumberController,
                        isEditable: true,
                        keyboardType: TextInputType.phone,
                        hintText: 'Mobile number',
                        prefixText: "",
                        isRequired: true,
                        //
                        errorText: null,
                        onChanged: (value) {},
                      ),
                      AppSpacing.smallHeight10,
                      Text("Purchase number", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.purchaseNumberController,
                        isEditable: true,
                        keyboardType: TextInputType.number,
                        hintText: 'Purchase number',
                        prefixText: "",
                        isRequired: true,
                        //
                        errorText: null,
                        onChanged: (value) {},
                      ),
                      AppSpacing.smallHeight10,
                      Text("Purchase date", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      GestureDetector(
                        onTap: () async {
                          final date = await CustomDatePicker.show(context: context, initialDate: provider.selectedDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                          if (date != null) provider.setDate(date);
                        },
                        child: Container(
                          height: 55,
                          padding: AppSpacing.allPadding12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: AppSpacing.kLargeRadius,
                          ),
                          child: Row(
                            children: [
                              SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg", size: 20.0),
                              AppSpacing.smallWidth,
                              Text(provider.selectedDate != null ? "${provider.selectedDate!.day.toString().padLeft(2, '0')}.${provider.selectedDate!.month.toString().padLeft(2, '0')}.${provider.selectedDate!.year}" : "Select date", style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),

                      AppSpacing.smallHeight10,
                    ],
                  ),
                ),

                AppSpacing.largeHeight,
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.redColor),
                          child: SizedBox(
                            width: size.width * 0.45,
                            child: OutlinedButton(
                              onPressed: () {
                                if (provider.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(borderRadius: AppSpacing.kLargeRadius),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 25),
                                  Text("Add items", style: AppTextStyles.customButtonTextStyle),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomOutlinedButton(
                        //   colors: AppColors.redColor,
                        //   text: "+ ",
                        //
                        //   borderColor: Colors.grey,
                        //   textColor: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.largeHeight,
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shirt', style: AppTextStyles.black87Text20),
                      AppSpacing.smallHeight10,
                      const Text(' vendor name', style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        isEditable: false,
                        keyboardType: TextInputType.datetime,
                        hintText: '',
                        prefixText: "",
                        isRequired: true,
                        //
                        errorText: null,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<AddPurchaseProvider>(
        builder: (context, provider, _) {
          return Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomOutlinedButton(text: "Cancel", onPressed: () => Navigator.pop(context), borderColor: Colors.grey, textColor: Colors.black, colors: Colors.white),
                ),
                AppSpacing.smallWidth10,
                Flexible(
                  child: CustomOutlinedButton(
                    colors: AppColors.redColor,
                    text: "Save",
                    onPressed: () {
                      if (provider.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Staff added successfully")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                      }
                    },
                    borderColor: Colors.grey,
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

  Widget _buildSelectField(BuildContext context, String title, String? value, List<String> options, Function(String) onSelected) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: AppSpacing.rSmallRadius)),
          builder: (_) => BottomSelectSheetPricing(title: title, options: options, onSelect: onSelected),
        );
      },
      child: Container(
        height: 58,
        // Smaller height
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: AppSpacing.kMediumRadius10,
          color: Colors.white,
        ),
        child: Text(value ?? "Select $title", style: AppTextStyles.greyText),
      ),
    );
  }
}
