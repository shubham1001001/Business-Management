import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/widgets/terms_and_pravacy.dart';

import '../../core/widgets/Custom_message_widget.dart';
import '../../providers/auth_provider/signup_provider.dart';
import '../../routes/app_routes_name.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            SizedBox(
              height: size.height,
              width: size.width,
              child: Image.network("https://images.unsplash.com/photo-1536152470836-b943b246224c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5hdHVyZSUyMHZzJTIwbnVydHVyZXxlbnwwfHwwfHx8MA%3D%3D", fit: BoxFit.cover),
              // Image.asset(
              //   'assets/images/bg.jpg', // Use your image path
              //   fit: BoxFit.cover,
              // ),
            ),
            // Dark overlay
            Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
            // Slogan
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.05,
              child: Text(
                'Bridging miles with\nmeaning',
                style: TextStyle(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w600),
              ),
            ),
            // White card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.6,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.all_inclusive, size: 20),
                          SizedBox(width: 6),
                          Text('Company Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),

                      // Country dropdown
                      // DropdownButtonFormField<String>(
                      //   value: auth.countryCode,
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      //   ),
                      //   items: const [
                      //     DropdownMenuItem(value: '+91', child: Text('🇮🇳 India')),
                      //     DropdownMenuItem(value: '+1', child: Text('🇺🇸 USA')),
                      //     DropdownMenuItem(value: '+44', child: Text('🇬🇧 UK')),
                      //   ],
                      //   onChanged: (val) => auth.updateCountryCode(val ?? '+91'),
                      // ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CountryCodePicker(
                              closeIcon: Icon(Icons.clear),
                              onChanged: (value) {
                                auth.updateCountryCode(value.code ?? '+91');
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: '+91',
                              favorite: ['+91', 'bharat'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      // Mobile Input
                      TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: auth.updatePhone,
                        decoration: InputDecoration(
                          prefixText: '${auth.countryCode} ',
                          hintText: 'Mobile number',
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      // OTP Button
                      Center(
                        child: SizedBox(
                          width: size.width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (auth.phone.length >= 10) {
                                Navigator.of(context).pushNamed(AppRoutesName.optScreen);
                                CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                              } else {
                                CustomSnackbar.show(context, message: "Please Inter Mobile Number", type: MessageType.error);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redcolor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Get OTP'),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('OR')),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      // Google Sign-in
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          label: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/images/googleSign.png")),
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      TermsAndPravacy(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
