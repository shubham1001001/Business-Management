import 'package:flutter/material.dart';

import '../../models/country_model.dart';

// class CountryDropdown extends StatelessWidget {
//   final String value;
//   final List<CountryModel> countries;
//   final ValueChanged<String?> onChanged;
//   final double height;
//   final double width;
//
//   const CountryDropdown({Key? key, required this.value, required this.countries, required this.onChanged, required this.height, required this.width}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width * 0.4,
//       child: DropdownButtonFormField<String>(
//         value: value,
//         icon: const Icon(Icons.arrow_drop_down, size: 18), // Small icon
//         decoration: InputDecoration(
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.03),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
//         ),
//         style: TextStyle(fontSize: 12), // Smaller text
//         items: countries.map((country) {
//           return DropdownMenuItem<String>(
//             value: country.code,
//             child: Text('${country.flag} ${country.name}', style: const TextStyle(fontSize: 12)),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

class CountryDropdown extends StatelessWidget {
  final String value;
  final List<CountryModel> countries;
  final ValueChanged<String?> onChanged;
  final double height;
  final double width;

  const CountryDropdown({Key? key, required this.value, required this.countries, required this.onChanged, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(5)),
      width: width * 0.4,
      child: DropdownButtonFormField<String>(
        value: value,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.03),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        ),
        style: TextStyle(fontSize: 12, color: Colors.black),
        items: countries.map((country) {
          return DropdownMenuItem<String>(
            value: country.code,
            child: Text('${country.flag} ${country.name}', style: TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
