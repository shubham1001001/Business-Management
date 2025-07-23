import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/spacing.dart';
import '../../core/widgets/CustomButton.dart';
import '../../core/widgets/custom_dropdown_widget.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../providers/add_item_provider/add_item_proivder.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Item"), leading: const BackButton()),
      body: Consumer<AddItemProvider>(
        builder: (context, provider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: AppSpacing.allPadding16,
                child: Container(
                  padding: AppSpacing.allPadding16,
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kSmallRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Item name"),
                      CustomInputField(isEditable: true, keyboardType: TextInputType.text, hintText: provider.itemName, prefixText: '', isRequired: true, errorText: null, onChanged: provider.updateItemName),
                      // TextFormField(initialValue: provider.itemName, onChanged: , decoration: _inputDecoration()),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Quantity"),
                                CustomInputField(isEditable: true, keyboardType: TextInputType.number, hintText: provider.itemName, prefixText: '0.00', isRequired: true, errorText: null, onChanged: provider.updateQuantity),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Unit"),
                                Container(
                                  height: 58, // Smaller height
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: AppSpacing.kMediumRadius10,
                                    color: Colors.white,
                                  ),
                                  child: CustomDropdown<String>(
                                    isExpanded: true,
                                    value: provider.unit,
                                    items: ['nos', 'kg', 'ltr', 'box'].map((unit) {
                                      return DropdownMenuItem(value: unit, child: Text(unit));
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) provider.updateUnit(value);
                                    },
                                  ),
                                ),
                                // DropdownButtonFormField<String>(
                                //   value: provider.unit,
                                //   decoration: _inputDecoration(),
                                //   items: ['nos', 'kg', 'ltr', 'box'].map((unit) {
                                //     return DropdownMenuItem(value: unit, child: Text(unit));
                                //   }).toList(),
                                //   onChanged: (value) {
                                //     if (value != null) provider.updateUnit(value);
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      _buildLabel("Price per unit"),
                      CustomInputField(isEditable: true, keyboardType: TextInputType.number, hintText: provider.itemName, prefixText: 'INR', isRequired: true, errorText: null, onChanged: provider.updatePrice),

                      SizedBox(height: size.height * 0.02),
                      _buildLabel("Total amount"),
                      CustomInputField(
                        controller: TextEditingController(text: provider.total.toStringAsFixed(2)),
                        isEditable: false,
                        keyboardType: TextInputType.number,
                        hintText: provider.itemName,
                        prefixText: '',
                        isRequired: true,
                        errorText: null,
                        onChanged: provider.updatePrice,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomButton(
                        colors: AppColors.redColor,
                        text: 'OK',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item submitted")));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: AppTextStyles.backBoldText),
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: AppSpacing.kMediumRadius),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
