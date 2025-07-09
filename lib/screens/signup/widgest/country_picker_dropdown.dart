import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider/signup_provider.dart';

class CountryPickerDropdown extends StatelessWidget {
  const CountryPickerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return DropdownButtonFormField<String>(
      value: auth.countryCode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      items: const [
        DropdownMenuItem(value: '+91', child: Text('🇮🇳 India')),
        DropdownMenuItem(value: '+1', child: Text('🇺🇸 USA')),
        DropdownMenuItem(value: '+44', child: Text('🇬🇧 UK')),
      ],
      onChanged: (value) {
        if (value != null) auth.updateCountryCode(value);
      },
    );
  }
}
