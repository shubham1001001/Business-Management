import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/CustomButton.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/dropdown_widgets.dart';
import '../../core/widgets/shimmer_widget_dropdown.dart';
import '../../providers/auth_provider/number_change_provider/change_number_provider.dart';
import '../../routes/app_routes_name.dart';

class MobileNumberChange extends StatelessWidget {
  MobileNumberChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<ChangeNumberProvider>(context, listen: false);
    if (auth.countries.isEmpty) {
      Future.microtask(() => auth.fetchCountries());
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppHeader(title: 'Change Number', endicon: false, backbutton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Image.asset("assets/images/change_numer_otp.png", fit: BoxFit.fitWidth),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.of(context).pushNamed(AppRoutesName.home);
              //       },
              //       child: Container(
              //         decoration: BoxDecoration(color: AppColors.grey100, borderRadius: BorderRadius.all(Radius.circular(10))),
              //         child: Padding(padding: const EdgeInsets.all(15.0), child: Icon(Icons.arrow_back, size: 20)),
              //       ),
              //     ),
              //
              //     Text('Enter your OTP here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              //     SizedBox(width: 6),
              //   ],
              // ),
              Center(
                child: Column(
                  children: [
                    Text("Enter your phone number", style: AppTextStyles.appBlackText18),
                    SizedBox(height: size.height * 0.02),
                    Text("+911234567890 is Your existing mobile number", style: AppTextStyles.greyText17),
                  ],
                ),
              ),
              Consumer<ChangeNumberProvider>(
                builder: (context, provider, child) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: AppSpacing.rRadius20),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Consumer<ChangeNumberProvider>(
                                    builder: (context, auth, _) {
                                      final countries = auth.countries;
                                      if (countries.isEmpty) {
                                        return ShimmerDropdownPlaceholder(width: size.width, height: size.height);
                                        ;
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

                                  // Consumer<ChangeNumberProvider>(
                                  //   builder: (context, auth, _) {
                                  //     final countries = auth.countries;
                                  //     if (countries.isEmpty) {
                                  //       return const Center(child: CircularProgressIndicator());
                                  //     }
                                  //
                                  //     return CountryDropdown(
                                  //       value: auth.countryCode,
                                  //       countries: countries,
                                  //       height: size.height,
                                  //       width: size.width,
                                  //       onChanged: (value) {
                                  //         if (value != null) {
                                  //           auth.updateCountryCode(value);
                                  //         }
                                  //       },
                                  //     );
                                  //   },
                                  // ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.025),
                            // Mobile Input
                            CustomInputField(
                              isEditable: true,
                              keyboardType: TextInputType.phone,
                              hintText: 'Mobile number',
                              prefixText: provider.countryCode,
                              isRequired: true, //
                              errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number',
                              onChanged: provider.updatePhone,
                            ),
                            // TextField(
                            //   keyboardType: TextInputType.phone,
                            //   onChanged: provider.updatePhone,
                            //   decoration: InputDecoration(
                            //     prefixText: '${provider.countryCode} ',
                            //     hintText: 'Mobile number',
                            //     errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number',
                            //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            //   ),
                            // ),
                            SizedBox(height: size.height * 0.025),
                            // OTP Button
                            CustomButton(
                              colors: AppColors.redColor,
                              text: 'Get OTP',
                              onPressed: () {
                                if (provider.phone.length >= 10) {
                                  Navigator.of(context).pushNamed(AppRoutesName.changeNumberOtpscreen, arguments: provider.phone);
                                  CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                                } else {
                                  CustomSnackbar.show(context, message: "Please Inter Mobile Number", type: MessageType.error);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
