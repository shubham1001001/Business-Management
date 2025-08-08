import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/svg_picture_widgets.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/custom_outline_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/widgets/custom_dropdown_widget.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/custom_text_field_gray_text.dart';
import '../../providers/add_account/add_account_provider.dart';
import '../../providers/add_staf/add_staf_provider.dart';

class AddAccountScreen extends StatefulWidget {
  AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AddAccountProvider>(context, listen: false).fetchAccountTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(leadingWidth: 28, title: const Text('Add Account', style: AppTextStyles.appBarBlackText)),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: AppSpacing.allPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSpacing.smallHeight10,
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      // Staff name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account name',
                            style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w800, color: AppColors.greyText.withOpacity(0.4)),
                          ),
                          AppSpacing.smallHeight10,

                          Consumer<AddAccountProvider>(
                            builder: (context, provider, child) {
                              return CustomInputField(
                                controller: provider.accountNameController,
                                isEditable: true,
                                keyboardType: TextInputType.text,
                                hintText: 'Account name',
                                prefixText: "",
                                isRequired: true, //
                                errorText: null,
                                onChanged: (value) {},
                              );
                            },
                          ),
                        ],
                      ),

                      AppSpacing.mediumHeight16,

                      // Mobile number
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Type',
                            style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w800, color: AppColors.greyText.withOpacity(0.4)),
                          ),
                          AppSpacing.smallHeight10,
                          Consumer<AddAccountProvider>(
                            builder: (context, provider, child) {
                              final accountTypes = provider.accountTypeList;

                              if (accountTypes.isEmpty) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                  ),
                                );
                              }

                              return Container(
                                height: 50, // Smaller height
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.textFieldBorderColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),

                                child: CustomDropdown<String>(
                                  hint: Text(
                                    'Select type',
                                    style: AppTextStyles.greyTextW500.copyWith(fontWeight: FontWeight.w700, color: AppColors.greyText.withOpacity(0.4)),
                                  ),
                                  isExpanded: true,
                                  value: accountTypes.contains(provider.accountType) ? provider.accountType : null,
                                  items: accountTypes.map((type) {
                                    return DropdownMenuItem(value: type, child: Text(type));
                                  }).toList(),
                                  onChanged: provider.setAccountType,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      AppSpacing.mediumHeight16,

                      // Address
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Description', style: AppTextStyles.backBoldTextW700),
                          AppSpacing.smallHeight10,

                          Consumer<AddAccountProvider>(
                            builder: (context, provider, child) {
                              return CustomTextFieldGrayText(
                                controller: provider.descriptionController,
                                isEditable: true,
                                maxLines: 4,
                                keyboardType: TextInputType.text,
                                hintText: 'Optional',
                                prefixText: "",
                                isRequired: true, //
                                errorText: null,
                                onChanged: (value) {},
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                AppSpacing.largeHeight,

                // Employee Type Dropdown
                Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppSpacing.smallWidth10,
                          Row(
                            children: [
                              SvgPictureWidgets(svgString: "assets/svg_icons/date_icon_svg.svg"),
                              AppSpacing.extraSmallWidth,
                              Text("12.02.2025", style: AppTextStyles.appRedText.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Opening balance',
                        style: AppTextStyles.greyBoldW500Text.copyWith(fontWeight: FontWeight.w800, color: AppColors.greyText.withOpacity(0.4)),
                      ),
                      AppSpacing.smallHeight10,
                      Consumer<AddAccountProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFieldGrayText(
                              controller: provider.openingBalanceController,
                              isEditable: true,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter opening balance',
                              prefixText: "",
                              isRequired: true, //
                              errorText: null,
                              onChanged: (value) {},
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AppSpacing.mediumHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<AddAccountProvider>(
                      builder: (context, provider, _) {
                        return Row(
                          children: [
                            Text(
                              "Allow Cost center",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.9)),
                            ),
                            const SizedBox(width: 8),
                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                  side: const BorderSide(
                                    width: 1.2, // 👈 Border width
                                    color: Colors.black, // 👈 Border color
                                  ),
                                ),
                              ),
                              child: Transform.scale(
                                scale: 1.3, // increase size
                                child: Checkbox(activeColor: AppColors.redColor, value: provider.allowCostCenter, onChanged: provider.toggleAllowCostCenter, visualDensity: VisualDensity.compact, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                AppSpacing.largeHeight,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: !isKeyboardOpen
          ? Container(
              color: Colors.white,
              padding: AppSpacing.allPadding16,
              child: Row(
                children: [
                  Flexible(
                    child: CustomOutlinedButton(text: "Cancel", onPressed: () => Navigator.pop(context), borderColor: Colors.black, textColor: Colors.black, colors: Colors.white),
                  ),
                  AppSpacing.smallWidth10,
                  Consumer<AddStafProvider>(
                    builder: (context, provider, child) {
                      return Flexible(
                        child: CustomOutlinedButton(
                          colors: AppColors.redColor,
                          text: "Submit",
                          onPressed: () {
                            if (provider.validateForm()) {
                              provider.submitForm();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(" Account added successfully")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                            }
                          },

                          textColor: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
