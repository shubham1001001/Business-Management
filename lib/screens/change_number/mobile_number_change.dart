import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/app_header.dart';
import '../../providers/auth_provider/number_change_provider/change_number_provider.dart';
import '../../routes/app_routes_name.dart';

class MobileNumberChange extends StatelessWidget {
  MobileNumberChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<ChangeNumberProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppHeader(title: 'Change Number', endicon: false),
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
                    Text("Enter your phone number", style: TextStyle(fontSize: 18)),
                    SizedBox(height: size.height * 0.02),
                    Text("+911234567890 is Your existing mobile number", style: TextStyle(color: AppColors.greyText, fontSize: 16)),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  print("${{auth.countryCode}}$auth.phone");
                                  Navigator.of(context).pushNamed(AppRoutesName.changeNumberOtpscreen, arguments: auth.phone);
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
