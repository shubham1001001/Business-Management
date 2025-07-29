import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_outline_button.dart';
import '../../providers/add_vehicle/add_vehicle_provider.dart';
import '../pricing_preference/widgets/bottom_select_sheet_widget.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Vehicle", style: AppTextStyles.appBarBlackText)),
      body: Consumer<AddVehicleProvider>(
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
                      Text("Vehicle number", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.vehicleNumberController,
                        isEditable: true,
                        keyboardType: TextInputType.text,
                        hintText: 'Vehicle number',
                        prefixText: "",
                        isRequired: true, //
                        errorText: provider.vehicleNumberError,
                        onChanged: (value) {},
                      ),
                      //    _buildTextField(context, controller: provider.vehicleNumberController, label: 'Vehicle number', hint: 'KL 11B 1040', errorText: provider.vehicleNumberError),
                      AppSpacing.smallHeight10,
                      Text("Vehicle name", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.vehicleNameController,
                        isEditable: true,
                        keyboardType: TextInputType.text,
                        hintText: 'Vehicle name here',
                        prefixText: "",
                        isRequired: true, //
                        errorText: provider.vehicleNameError,
                        onChanged: (value) {},
                      ),
                      //_buildTextField(context, controller: provider.vehicleNameController, label: 'Vehicle name', hint: 'Vehicle name here', errorText: provider.vehicleNameError),
                      AppSpacing.smallHeight10,
                      Text("Vehicle owner", style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      _buildSelectField(context, "owner", provider.selectedOwner, provider.owners, provider.setOwner),
                    ],
                  ),
                ),
                AppSpacing.largeHeight,

                // Employee Type Dropdown
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppSpacing.smallWidth10,
                          Row(
                            children: [
                              SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg", size: 20.0),
                              AppSpacing.extraSmallWidth,
                              Text("12.02.2025", style: AppTextStyles.appRedText),
                            ],
                          ),
                        ],
                      ),
                      const Text('Opening balance', style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.smallHeight10,
                      CustomInputField(
                        controller: provider.openingBalanceController,
                        isEditable: true,
                        keyboardType: TextInputType.text,
                        hintText: 'Enter opening balance',
                        prefixText: "",
                        isRequired: true, //
                        errorText: null,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                AppSpacing.largeHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Capacity', style: AppTextStyles.textSize16),
                    AppSpacing.mediumHeight16,

                    // Capacity Header Row
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCapacityHeaderText(title: 'Basic'),
                              _buildCapacityHeaderText(title: 'Unit'),
                              _buildCapacityHeaderText(title: 'Type'),
                            ],
                          ),
                          AppSpacing.mediumHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomInputField(
                                  controller: provider.capacityController,
                                  isEditable: true,
                                  keyboardType: TextInputType.number,
                                  hintText: 'Capacity',
                                  prefixText: "",
                                  isRequired: true, //
                                  errorText: null,
                                  onChanged: (value) {},
                                ),
                              ),
                              AppSpacing.extraSmallWidth,
                              Flexible(
                                child: CustomInputField(
                                  controller: provider.unitController,
                                  isEditable: true,
                                  keyboardType: TextInputType.number,
                                  hintText: 'Unit',
                                  prefixText: "",
                                  isRequired: true, //
                                  errorText: null,
                                  onChanged: (value) {},
                                ),
                              ),
                              AppSpacing.extraSmallWidth,
                              Flexible(
                                child: CustomInputField(
                                  controller: provider.typeBalanceController,
                                  isEditable: true,
                                  keyboardType: TextInputType.text,
                                  hintText: 'Type',
                                  prefixText: "",
                                  isRequired: true, //
                                  errorText: null,
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                AppSpacing.largeHeight,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
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
                              if (provider.validate()) {
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCapacityHeaderText({required String title}) {
    return Expanded(
      child: Center(child: Text(title, style: AppTextStyles.greyBoldText)),
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
        border: Border.all(color: AppColors.textFieldBorderColor),
        borderRadius: AppSpacing.kMediumRadius10,
        color: Colors.white,
      ),
      child: Text(value ?? "Select $title", style: AppTextStyles.greyText),
    ),
  );
}
