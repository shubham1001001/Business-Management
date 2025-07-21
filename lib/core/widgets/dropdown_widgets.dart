import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(5)),
      width: width * 0.35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodePicker(onChanged: onChanged, initialSelection: '+91', showCountryOnly: false, showOnlyCountryWhenClosed: false, alignLeft: false),
          Expanded(child: Icon(Icons.keyboard_arrow_down)),
        ],
      ),
    );
  }
}
