import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/pricing_preference/widgets/bottom_select_sheet_widget.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_date_picker.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_outline_button.dart';
import '../../providers/pricing_preference/pricing_preference_provider.dart';

class PricingPreferenceScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<String> vendors = List.generate(10, (i) => "Vendor ${i + 1}");
  final List<String> units = ['Kg', 'Ltr', 'Pack'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Pricing Preference", style: AppTextStyles.appBarBlackText)),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Consumer<PricingPreferenceProvider>(
          builder: (context, provider, _) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vendor
                    Text("Select preferred vendor", style: AppTextStyles.greyBoldText),
                    AppSpacing.smallHeight10,
                    _buildSelectField(context, " preferred vendor", provider.selectedVendor, vendors, provider.selectVendor),
                    AppSpacing.largeHeight,

                    // Price box
                    _buildCard([AppSpacing.smallHeight10, const Text("Price", style: AppTextStyles.boldText), AppSpacing.largeHeight, Text("Selling price", style: AppTextStyles.greyBoldText), AppSpacing.extraSmallHeight, CustomInputField(isEditable: true, keyboardType: TextInputType.text, hintText: provider.sellingPrice, prefixText: '', isRequired: true, errorText: null, onChanged: provider.setSellingPrice), AppSpacing.mediumHeight, Text("Purchase price", style: AppTextStyles.greyBoldText), AppSpacing.smallHeight10, CustomInputField(isEditable: true, keyboardType: TextInputType.text, hintText: provider.purchasePrice, prefixText: '', isRequired: true, errorText: null, onChanged: provider.setPurchasePrice)]),

                    AppSpacing.mediumHeight,

                    // Opening Stock
                    _buildCard([
                      const Text("Opening Stock", style: AppTextStyles.boldText),
                      AppSpacing.mediumHeight16,
                      Text("Date", style: AppTextStyles.greyBoldText),
                      AppSpacing.smallHeight10,
                      GestureDetector(
                        onTap: () async {
                          final date = await CustomDatePicker.show(context: context, initialDate: provider.selectedDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                          if (date != null) provider.setDate(date);
                        },
                        child: Container(
                          height: 50,
                          padding: AppSpacing.allPadding12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.textFieldBorderColor),
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
                      AppSpacing.mediumHeight16,
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Qty", style: AppTextStyles.backBoldText),
                                AppSpacing.extraSmallHeight,
                                SizedBox(
                                  height: 47,
                                  child: CustomInputField(isEditable: true, keyboardType: TextInputType.number, hintText: provider.openingQty, prefixText: '', isRequired: true, errorText: null, onChanged: provider.setQty),
                                ),
                                //   _buildTextField(hint: "Qty", initial: provider.openingQty, onChanged: provider.setQty, inputType: TextInputType.number),
                              ],
                            ),
                          ),
                          AppSpacing.smallWidth10,

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("unit", style: AppTextStyles.backBoldText),
                                AppSpacing.extraSmallHeight,
                                SizedBox(
                                  height: 47,
                                  child: CustomInputField(isEditable: true, keyboardType: TextInputType.number, hintText: provider.selectedUnit, prefixText: '', isRequired: true, errorText: null, onChanged: provider.selectUnit),
                                ),
                                //_buildSelectField(context, "unit", provider.selectedUnit, units, provider.selectUnit)])),
                              ],
                            ),
                          ),

                          // Buttons
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<PricingPreferenceProvider>(
        builder: (context, provider, child) {
          return Container(
            color: Colors.white,
            padding: AppSpacing.allPadding16,
            child: Row(
              children: [
                Flexible(
                  child: CustomOutlinedButton(text: "Cancel", onPressed: () => Navigator.pop(context), borderColor: Colors.black, textColor: Colors.black, colors: Colors.white),
                ),
                AppSpacing.mediumWidth,
                Flexible(
                  child: CustomOutlinedButton(
                    colors: AppColors.redColor,
                    text: "Save",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        provider.submitForm();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Staff added successfully")));
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

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: AppSpacing.allPadding12,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: AppSpacing.kLargeRadius),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildTextField({required String hint, required String initial, required Function(String) onChanged, TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      initialValue: initial,
      keyboardType: inputType,
      decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder()),
      validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
      onChanged: onChanged,
    );
  }

  Widget _buildSelectField(BuildContext context, String title, String? value, List<String> options, Function(String) onSelected) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: AppSpacing.rSmallRadius)),
          builder: (_) => BottomSelectSheetPricing(title: title, options: options, onSelect: onSelected, type: "Apply"),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textFieldBorderColor),
          borderRadius: AppSpacing.kLargeRadius,
        ),
        child: Text(value ?? "Select $title", style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
