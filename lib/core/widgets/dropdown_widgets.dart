import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../models/country_model.dart';

class CountryDropdown extends StatelessWidget {
  final String value;
  final List<CountryModel> countries;
  final onChanged;
  final double height;
  final double width;

  const CountryDropdown({Key? key, required this.value, required this.countries, required this.onChanged, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldBorderColor),
        borderRadius: AppSpacing.kLargeRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodePicker(
            padding: EdgeInsetsGeometry.all(0),
            boxDecoration: BoxDecoration(
              border: Border.all(color: AppColors.textFieldBorderColor),
              borderRadius: AppSpacing.kLargeRadius,
            ),
            flagWidth: 20,
            onChanged: onChanged,
            initialSelection: '+91',
            showCountryOnly: false,
            showOnlyCountryWhenClosed: true,
            alignLeft: false,
            textStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.9)),
          ),

          Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.black54.withOpacity(0.6)),
          AppSpacing.extraSmallWidth,
        ],
      ),
    );
  }
}
