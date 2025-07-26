import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/custom_outline_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/widgets/custom_dropdown_widget.dart';
import '../../core/widgets/custom_input_field.dart';
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
      appBar: AppBar(title: const Text('Add Account', style: AppTextStyles.appBarBlackText)),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: AppSpacing.allPadding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image upload section
                  Container(
                    padding: AppSpacing.allPadding16,
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        // Staff name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Account name', style: AppTextStyles.greyBoldW500Text),
                            AppSpacing.extraSmallHeight,

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
                            const Text('Account Type', style: AppTextStyles.greyBoldW500Text),
                            AppSpacing.extraSmallHeight,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                                  child: CustomDropdown<String>(
                                    hint: const Text('Select Type'),
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
                            const Text('Description', style: AppTextStyles.greyBoldW500Text),
                            AppSpacing.extraSmallHeight,

                            Consumer<AddAccountProvider>(
                              builder: (context, provider, child) {
                                return CustomInputField(
                                  controller: provider.descriptionController,
                                  isEditable: true,
                                  maxLines: 3,
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
                                Icon(Icons.date_range_outlined),
                                AppSpacing.extraSmallWidth,
                                Text("12.02.2025", style: AppTextStyles.appRedText),
                              ],
                            ),
                          ],
                        ),
                        const Text('Opening Balance', style: AppTextStyles.greyBoldW500Text),
                        AppSpacing.extraSmallWidth,
                        Consumer<AddAccountProvider>(
                          builder: (context, provider, child) {
                            return CustomInputField(
                              controller: provider.openingBalanceController,
                              isEditable: true,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter opening balance',
                              prefixText: "",
                              isRequired: true, //
                              errorText: null,
                              onChanged: (value) {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.largeHeight,
                ],
              ),
            ),
            !isKeyboardOpen
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
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
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
