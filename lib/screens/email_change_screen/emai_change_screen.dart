import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/providers/auth_provider/email_provider/email_provider.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/app_header.dart';
import '../../providers/auth_provider/number_change_provider/change_number_provider.dart';
import '../../routes/app_routes_name.dart';

class EmaiChangeScreen extends StatelessWidget {
  EmaiChangeScreen({Key? key}) : super(key: key);

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
              SizedBox(
                height: size.height * 0.45,
                width: size.width,
                child: Image.asset("assets/images/emialIcon.png", fit: BoxFit.cover),
              ),
              Center(
                child: Column(
                  children: [
                    Text("Enter your Email ID", style: TextStyle(fontSize: 18)),
                    SizedBox(height: size.height * 0.02),
                    Text("is Your Current Email ID", style: TextStyle(color: AppColors.greyText, fontSize: 17)),
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
                        Consumer<EmailProvider>(
                          builder: (context, auth, _) {
                            return TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: auth.updateEmail,
                              decoration: InputDecoration(
                                hintText: 'Type Your email id',
                                errorText: auth.emailError,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: size.height * 0.025),
                        // OTP Button
                        Center(
                          child: SizedBox(
                            width: size.width * 0.45,
                            child: ElevatedButton(
                              onPressed: () {
                                final auth = Provider.of<EmailProvider>(context, listen: false);
                                if (auth.emailError == null) {
                                  CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                                  Navigator.of(context).pushNamed(AppRoutesName.emailChangeScreenOtp, arguments: auth.email);
                                } else {
                                  CustomSnackbar.show(context, message: "Please Inter Valid Email", type: MessageType.error);
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
