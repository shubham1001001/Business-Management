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
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Purchase", style: AppTextStyles.appBarBlackText)),
        body: Consumer<AddPurchaseProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              padding: AppSpacing.allPadding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.smallHeight10,
                  Container(
                    padding: AppSpacing.allPadding16,
                    decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.mediumHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg", size: 20.0),
                            AppSpacing.extraSmallWidth,
                            Text("12.02.2025", style: AppTextStyles.appRedText),
                          ],
                        ),
                        AppSpacing.mediumHeight16,
                        Text("Vendor name", style: AppTextStyles.greyBoldW500Text),
                        AppSpacing.smallHeight10,
                        _buildSelectField(context, "Vendor", provider.selectedVendorName, provider.vendors, provider.setVendorName),

                        AppSpacing.mediumHeight16,
                        Text("Mobile number", style: AppTextStyles.greyBoldW500Text),
                        AppSpacing.smallHeight10,
                        SizedBox(
                          height: 50,
                          child: CustomInputField(
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
                        ),
                        AppSpacing.mediumHeight16,
                        Text("Bill number", style: AppTextStyles.greyBoldW500Text),
                        AppSpacing.smallHeight10,
                        SizedBox(
                          height: 50,
                          child: CustomInputField(
                            controller: provider.purchaseNumberController,
                            isEditable: true,
                            keyboardType: TextInputType.number,
                            hintText: 'Bill number',
                            prefixText: "",
                            isRequired: true,
                            //
                            errorText: null,
                            onChanged: (value) {},
                          ),
                        ),
                        AppSpacing.mediumHeight16,
                        Text("Bill date", style: AppTextStyles.greyBoldW500Text),
                        AppSpacing.smallHeight10,
                        GestureDetector(
                          onTap: () async {
                            final date = await CustomDatePicker.show(context: context, initialDate: provider.selectedDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                            if (date != null) provider.setDate(date);
                          },
                          child: Container(
                            height: 49,
                            padding: AppSpacing.allPadding12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.textFieldBorderColor),
                              borderRadius: AppSpacing.kLargeRadius,
                            ),
                            child: Row(
                              children: [
                                SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg", size: 20.0, color: AppColors.greyLight),
                                AppSpacing.smallWidth,
                                Text(provider.selectedDate != null ? "${provider.selectedDate!.day.toString().padLeft(2, '0')}.${provider.selectedDate!.month.toString().padLeft(2, '0')}.${provider.selectedDate!.year}" : "Select date", style: provider.selectedDate != null ? TextStyle(color: AppColors.redColor) : AppTextStyles.greyText),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if (provider.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                            }
                          },
                          child: Container(
                            width: 170,
                            height: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.redColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 25, color: Colors.white),
                                Text("Add items", style: AppTextStyles.customButtonTextWhiteStyle),
                              ],
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
                  AppSpacing.largeHeight,
                  Container(
                    padding: AppSpacing.allPadding16,
                    decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shirt', style: AppTextStyles.blackText20),
                        AppSpacing.smallHeight10,
                        Text(' vendor name', style: AppTextStyles.openSansFontStyleTextW400),
                        AppSpacing.smallHeight10,
                        SizedBox(width: double.infinity, height: 40, child: Text("")),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomOutlinedButton(text: "Cancel", onPressed: () => Navigator.pop(context), borderColor: Colors.black, textColor: Colors.black, colors: Colors.white),
                    ),
                    AppSpacing.mediumWidth16,
                    Flexible(
                      child: CustomOutlinedButton(
                        colors: AppColors.redColor,
                        text: "Save",
                        onPressed: () {
                          if (provider.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Save successfully")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                          }
                        },

                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
        height: 50,
        // Smaller height
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textFieldBorderColor),
          borderRadius: AppSpacing.kLargeRadius,
          color: Colors.white,
        ),
        child: Text(value ?? "Select $title", style: AppTextStyles.greyText),
      ),
    );
  }
}
