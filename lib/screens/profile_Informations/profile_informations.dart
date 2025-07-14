import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../providers/profile_information_provider/profile_information_provider.dart';

class ProfileInformations extends StatelessWidget {
  const ProfileInformations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
        leading: const BackButton(),
        actions: [
          Consumer<ProfileInformationProvider>(
            builder: (context, provider, _) {
              return IconButton(icon: const Icon(Icons.edit), onPressed: provider.toggleFirstNameEditing);
            },
          ),
        ],
      ),
      body: Padding(
        padding: AppSpacing.allPadding16,
        child: Consumer<ProfileInformationProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: AppSpacing.allPadding12,
                  child: Column(
                    children: [
                      buildEditableTextField(label: 'First name', value: 'Nandana', isEditable: provider.isEditingFirstName),
                      buildReadOnlyField('Last name', 'example text like this'),
                      buildEditableField(label: 'Mobile number', value: '9876543210', actionLabel: 'Change number', isEditable: provider.isEditingMobile, onTap: provider.toggleMobileEditing),
                      buildEditableField(label: 'Email id', value: 'nandana900@gmail.com', actionLabel: 'Change email', isEditable: provider.isEditingEmail, onTap: provider.toggleEmailEditing),
                      buildReadOnlyField('Enterprise name', 'ABC company'),
                      buildReadOnlyField('Financial year', 'Select financial year'),
                      buildReadOnlyField('Address', 'Sample here'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(label, style: AppTextStyles.textSize13)],
          ),
          const SizedBox(height: 6),
          CustomInputField(
            isEditable: false,
            keyboardType: TextInputType.phone,
            hintText: value,
            prefixText: '',
            isRequired: true, //
            errorText: null,
            onChanged: (value) {},
          ),
        ],
      ),
      // TextFormField(
      //   initialValue: value,
      //   enabled: false,
      //   decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), filled: true, fillColor: Colors.white),
      // ),
    );
  }

  Widget buildEditableTextField({required String label, required String value, required bool isEditable}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(label, style: AppTextStyles.textSize13)],
          ),
          const SizedBox(height: 6),
          CustomInputField(
            isEditable: isEditable,
            keyboardType: TextInputType.text,
            hintText: value,
            prefixText: '',
            isRequired: true, //
            errorText: null,
            onChanged: (value) {},
          ),
        ],
      ),
      // TextFormField(
      //   initialValue: value,
      //   enabled: isEditable,
      //   decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), filled: true, fillColor: Colors.white),
      // ),
    );
  }

  Widget buildEditableField({required String label, required String value, required String actionLabel, required bool isEditable, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.textSize13),
              GestureDetector(
                onTap: onTap,
                child: Text(actionLabel, style: AppTextStyles.redText),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Consumer<ProfileInformationProvider>(
            builder: (context, provider, child) {
              return CustomInputField(
                isEditable: isEditable,
                keyboardType: "Mobile number" == label ? TextInputType.phone : TextInputType.emailAddress,
                hintText: value,
                prefixText: '',
                isRequired: true, //
                errorText: "Mobile number" == label
                    ? provider.phone.isEmpty || provider.isPhoneValid
                          ? null
                          : 'Enter valid 10-digit number'
                    : provider.emailError,
                onChanged: "Mobile number" == label ? provider.updatePhone : provider.updateEmail,
              );
            },
          ),
          // TextFormField(
          //   initialValue: value,
          //   enabled: isEditable,
          //   decoration: const InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
          // ),
        ],
      ),
    );
  }
}
