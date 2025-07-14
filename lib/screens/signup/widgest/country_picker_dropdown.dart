import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider/signup_provider.dart';

class CountryPickerDropdown extends StatelessWidget {
  const CountryPickerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final countries = auth.countries;

        if (countries.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return DropdownButtonFormField<String>(
          value: auth.countryCode,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: MediaQuery.of(context).size.height * 0.015),
          ),
          items: countries.map((country) {
            return DropdownMenuItem(value: country.code, child: Text('${country.flag} ${country.name}'));
          }).toList(),
          onChanged: (value) {
            if (value != null) auth.updateCountryCode(value);
          },
        );
      },
    );
  }
}
