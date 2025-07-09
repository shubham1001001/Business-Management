import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider/signup_provider.dart';

class MobileInputField extends StatelessWidget {
  const MobileInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return TextField(
      keyboardType: TextInputType.phone,
      onChanged: (value) => auth.updatePhone(value),
      decoration: InputDecoration(
        prefixText: "${auth.countryCode} ",
        hintText: 'Mobile number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
