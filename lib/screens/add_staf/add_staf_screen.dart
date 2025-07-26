import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/custom_outline_button.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../providers/add_staf/add_staf_provider.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (picked != null) {
      context.read<AddStafProvider>().setProfileImage(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Staff', style: AppTextStyles.appBarBlackText)),
      body: Stack(
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
                      Row(
                        children: [
                          Consumer<AddStafProvider>(
                            builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () => _pickImage(context),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: AppSpacing.kMediumRadius,
                                    color: Colors.white,
                                  ),
                                  child: provider.profileImage != null
                                      ? ClipRRect(
                                          borderRadius: AppSpacing.kMediumRadius,
                                          child: Image.file(provider.profileImage!, fit: BoxFit.cover),
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            SvgPictureWidgets(svgString: "assets/svg_icons/user_profile.svg", size: 45.0),
                                            Text('Upload', style: AppTextStyles.redW800Text),
                                          ],
                                        ),
                                ),
                              );
                            },
                          ),
                          AppSpacing.smallWidth10,
                          Expanded(
                            child: DottedBorder(
                              dashPattern: [10, 10],
                              // [dot size, space]
                              color: Colors.grey,
                              borderType: BorderType.RRect,
                              radius: AppSpacing.rMediumRadius,
                              strokeWidth: 1.5,
                              child: Container(
                                padding: AppSpacing.allPadding8,
                                width: double.infinity,
                                color: Colors.grey.shade100,
                                child: const Text(
                                  '* Image must be below 10mb\n'
                                  '* Supported format JPG, JPEG\n'
                                  '* Width and height should be 200px',
                                  style: AppTextStyles.textSize13,
                                ),
                              ),
                            ),
                            // Text(
                            //   '* Image must be below 10mb\n'
                            //   '* Supported format JPG, JPEG\n'
                            //   '* Width and height should be 200px',
                            //   style: TextStyle(fontSize: 12),
                            // ),
                          ),
                        ],
                      ),
                      AppSpacing.mediumHeight,

                      // Staff name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Staff name', style: AppTextStyles.greyBoldW500Text),
                          AppSpacing.extraSmallHeight,

                          Consumer<AddStafProvider>(
                            builder: (context, provider, child) {
                              return CustomInputField(
                                controller: provider.nameController,
                                isEditable: true,
                                keyboardType: TextInputType.text,
                                hintText: 'Staff name',
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
                          const Text('Mobile Number', style: AppTextStyles.greyBoldW500Text),
                          AppSpacing.extraSmallHeight,

                          Consumer<AddStafProvider>(
                            builder: (context, provider, child) {
                              return CustomInputField(
                                controller: provider.phoneController,
                                isEditable: true,
                                keyboardType: TextInputType.phone,
                                hintText: 'Mobile number',
                                prefixText: "",
                                isRequired: true, //
                                errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number',
                                onChanged: provider.updatePhone,
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
                          const Text('Address', style: AppTextStyles.greyBoldW500Text),
                          AppSpacing.extraSmallHeight,

                          Consumer<AddStafProvider>(
                            builder: (context, provider, child) {
                              return CustomInputField(
                                controller: provider.addressController,
                                isEditable: true,
                                maxLines: 3,
                                keyboardType: TextInputType.text,
                                hintText: 'Address',
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
                      const Text('Employee Type', style: AppTextStyles.greyBoldW500Text),
                      AppSpacing.extraSmallHeight,

                      Consumer<AddStafProvider>(
                        builder: (context, provider, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton<String>(
                              style: TextStyle(color: Colors.black),
                              value: provider.employeeType,
                              underline: const SizedBox(),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'Full Time', child: Text('Full Time')),
                                DropdownMenuItem(value: 'Part Time', child: Text('Part Time')),
                                DropdownMenuItem(value: 'Intern', child: Text('Intern')),
                              ],
                              onChanged: provider.setEmployeeType,
                            ),
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
          Align(
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
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Staff added successfully")));
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
          ),
        ],
      ),
    );
  }
}
