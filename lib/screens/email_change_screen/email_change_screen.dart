import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/providers/auth_provider/email_provider/email_provider.dart';

import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../routes/app_routes_name.dart';

class EmailChangeScreen extends StatelessWidget {
  EmailChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppHeader(title: 'Change Email', endicon: false, backbutton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.45,
                width: size.width * 0.6,
                child: Image.asset("assets/images/emialIcon.png", fit: BoxFit.fitWidth),
              ),
              Center(
                child: Column(
                  children: [
                    Text("Enter your Email ID", style: AppTextStyles.appBlackText18),
                    SizedBox(height: size.height * 0.02),
                    Text("is Your Current Email ID", style: AppTextStyles.greyText17),
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
                        SizedBox(height: size.height * 0.025),
                        // Mobile Input
                        Consumer<EmailProvider>(
                          builder: (context, auth, _) {
                            return CustomInputField(
                              isEditable: true,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Type Your email id',
                              prefixText: '',
                              isRequired: true, //
                              errorText: auth.emailError,
                              onChanged: auth.updateEmail,
                            );
                            // TextField(
                            //   keyboardType: TextInputType.emailAddress,
                            //   onChanged: auth.updateEmail,
                            //   decoration: InputDecoration(
                            //     hintText: 'Type Your email id',
                            //     errorText: auth.emailError,
                            //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            //   ),
                            // );
                          },
                        ),

                        SizedBox(height: size.height * 0.025),
                        // OTP Button
                        Center(
                          child: CustomAuthButton(
                            text: "Get OTP",
                            onTap: () {
                              final auth = Provider.of<EmailProvider>(context, listen: false);
                              if (auth.emailError == null) {
                                CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                                Navigator.of(context).pushNamed(AppRoutesName.emailChangeScreenOtp, arguments: auth.email);
                              } else {
                                CustomSnackbar.show(context, message: "Please Inter Valid Email", type: MessageType.error);
                              }
                            },
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
