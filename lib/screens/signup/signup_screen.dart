import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/terms_and_pravacy.dart';

import '../../core/constants/spacing.dart';
import '../../core/widgets/CustomButton.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/dropdown_widgets.dart';
import '../../core/widgets/shimmer_widget_dropdown.dart';
import '../../providers/auth_provider/signup_provider.dart';
import '../../routes/app_routes_name.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Fetch countries once if not already loaded
    final auth = Provider.of<AuthProvider>(context, listen: false);
    if (auth.countries.isEmpty) {
      Future.microtask(() => auth.fetchCountries());
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                // Background image
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.network("https://images.unsplash.com/photo-1536152470836-b943b246224c?w=500&auto=format&fit=crop&q=60", fit: BoxFit.cover),
                ),

                // Overlay
                Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),

                // Slogan
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.05,
                  child: const Text('Bridging miles with\nmeaning', style: AppTextStyles.white70BoldText20),
                ),

                // Main form
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.all_inclusive, size: 20),
                              SizedBox(width: 6),
                              Text('Company Name', style: AppTextStyles.title16),
                            ],
                          ),

                          SizedBox(height: size.height * 0.025),

                          /// Dynamic Country Dropdown
                          Consumer<AuthProvider>(
                            builder: (context, auth, _) {
                              final countries = auth.countries;
                              if (countries.isEmpty) {
                                return ShimmerDropdownPlaceholder(width: size.width, height: size.height);
                              }

                              return CountryDropdown(
                                value: auth.countryCode,
                                countries: countries,
                                height: size.height,
                                width: size.width,
                                onChanged: (value) {
                                  if (value != null) {
                                    auth.updateCountryCode(value);
                                  }
                                },
                              );
                            },
                          ),

                          SizedBox(height: size.height * 0.025),

                          /// Mobile Number Field
                          CustomInputField(
                            isEditable: true,
                            keyboardType: TextInputType.phone,
                            hintText: 'Mobile number',
                            prefixText: provider.countryCode,
                            isRequired: true, //
                            errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number',
                            onChanged: provider.updatePhone,
                          ),
                          SizedBox(height: size.height * 0.035),

                          /// Get OTP Button
                          CustomButton(
                            colors: AppColors.redColor,
                            text: 'Get OTP',
                            onPressed: () {
                              if (provider.isPhoneValid) {
                                Navigator.of(context).pushNamed(AppRoutesName.optScreen);
                                CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                              } else {
                                CustomSnackbar.show(context, message: "Please enter a valid mobile number", type: MessageType.error);
                              }
                            },
                          ),

                          SizedBox(height: size.height * 0.04),

                          /// OR Divider
                          Row(
                            children: const [
                              Expanded(child: Divider(color: Colors.grey)),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('OR')),
                              Expanded(child: Divider(color: Colors.grey)),
                            ],
                          ),

                          SizedBox(height: size.height * 0.025),

                          /// Google Sign-in
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: Padding(padding: AppSpacing.allPadding8, child: Image.asset("assets/images/googleSign.png")),
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                            ),
                          ),

                          SizedBox(height: size.height * 0.025),

                          /// Terms and Privacy
                          const TermsAndPravacy(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
