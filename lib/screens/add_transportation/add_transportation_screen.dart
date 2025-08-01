import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_outline_button.dart';
import '../../providers/add_transportation/add_transportation_provider.dart';
import '../pricing_preference/widgets/bottom_select_sheet_widget.dart';

class AddTransportationScreen extends StatelessWidget {
  const AddTransportationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transportation")),
      body: Consumer<AddTransportationProvider>(
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
                      Text("Collection point", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, "collection point", provider.selectedCollectionPoint, provider.owners, provider.setCollectionPoint),

                      AppSpacing.smallHeight10,
                      Text("Delivery point", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, "delivery point", provider.selectedDeliveryPoint, provider.owners, provider.setDeliveryPoint),
                      AppSpacing.smallHeight10,
                      Text("Vehicle number", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, "Vehicle number", provider.selectedVehicleNumber, provider.owners, provider.setVehicleNumber),
                      AppSpacing.smallHeight10,
                      Text("Driver", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, "Driver", provider.selectedDriver, provider.owners, provider.setDriver),
                      AppSpacing.smallHeight10,
                      Text("Rent", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.rentAmountController,
                        isEditable: true,
                        keyboardType: TextInputType.text,
                        hintText: 'Rent amount',
                        prefixText: "",
                        isRequired: true, //
                        errorText: null,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                AppSpacing.largeHeight,

                AppSpacing.largeHeight,
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.white,
                    child: CustomOutlinedButton(
                      colors: AppColors.redColor,
                      text: "Ok",
                      onPressed: () {
                        if (provider.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                        }
                      },
                      borderColor: Colors.grey,
                      textColor: Colors.white,
                    ),
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
      height: 58, // Smaller height
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
