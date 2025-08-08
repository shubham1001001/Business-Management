import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/svg_picture_widgets.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/terms_and_pravacy.dart';

import '../../core/constants/spacing.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../core/widgets/custom_textfield_numder.dart';
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
                  height: size.height * 0.50,
                  width: size.width,
                  child: Image.asset("assets/images/signup_background.jpg", fit: BoxFit.fitWidth),
                ),

                // Overlay
                Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),

                // Slogan
                Positioned(
                  top: size.height * 0.15,
                  left: size.width * 0.05,
                  child: Column(children: [Text('Bridging miles with\nmeaning', style: AppTextStyles.heading1FontStyleText)]),
                ),

                // Main form
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.55,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppSpacing.mediumHeight16,
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPictureWidgets(svgString: "assets/svg_icons/company_icons_svg.svg", size: 16.0),
                                AppSpacing.extraSmallWidth,
                                Text('Company Name', style: AppTextStyles.openSansFontStyleTextW400),
                              ],
                            ),
                          ),

                          SizedBox(height: size.height * 0.022),

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
                                  print(value);
                                  if (value != null) {
                                    auth.updateCountryCode(value.toString());
                                  }
                                },
                              );
                            },
                          ),

                          SizedBox(height: size.height * 0.021),

                          /// Mobile Number Field
                          MobileNumberField(errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number', onChanged: provider.updatePhone),
                          SizedBox(height: size.height * 0.035),

                          /// Get OTP Button
                          Center(
                            child: CustomAuthButton(
                              text: "Get OTP",
                              onTap: () {
                                if (provider.isPhoneValid) {
                                  Navigator.of(context).pushNamed(AppRoutesName.optScreen);
                                  CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                                } else {
                                  CustomSnackbar.show(context, message: "Please enter a valid mobile number", type: MessageType.error);
                                }
                              },
                            ),
                          ),

                          SizedBox(height: size.height * 0.052),

                          /// OR Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.black87)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('OR', style: AppTextStyles.backBoldText.copyWith(fontWeight: FontWeight.w800)),
                              ),
                              Expanded(child: Divider(color: Colors.black87)),
                            ],
                          ),

                          SizedBox(height: size.height * 0.028),

                          /// Google Sign-in
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPictureWidgets(svgString: "assets/svg_icons/google_icon_svg.svg", size: 30.0),
                                AppSpacing.smallWidth10,
                                Text("Sign in with Google", style: AppTextStyles.blackBoldText15),
                              ],
                            ),
                          ),

                          SizedBox(height: size.height * 0.06),

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
