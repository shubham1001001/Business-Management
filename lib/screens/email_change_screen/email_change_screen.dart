import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/providers/auth_provider/email_provider/email_provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
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
        appBar: AppBar(leadingWidth: 28, title: const Text("Change Number", style: AppTextStyles.appBarBlackText)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.4,
                child: Image.asset("assets/images/emialIcon.png", fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("Enter your Email ID", style: AppTextStyles.backBoldTextW600),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: FittedBox(child: Text("Loremipsum4@gmail.com is Your Current Email ID", style: AppTextStyles.greyText17)),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
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
                            return
                            //   CustomInputField(
                            //   isEditable: true,
                            //   keyboardType: TextInputType.emailAddress,
                            //   hintText: 'Type Your email id',
                            //   prefixText: '',
                            //   isRequired: true, //
                            //   errorText: auth.emailError,
                            //   onChanged: auth.updateEmail,
                            // );
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: auth.updateEmail,
                              decoration: InputDecoration(
                                hintStyle: AppTextStyles.greyTextW500,
                                hintText: 'Type Your email id',
                                errorText: auth.emailError,
                                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: AppColors.textFieldBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.5),
                                ),
                                border: OutlineInputBorder(borderRadius: AppSpacing.kMediumRadius),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 38),
                        // OTP Button
                        Center(
                          child: CustomAuthButton(
                            width: 172,
                            height: 45,
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
                        SizedBox(height: 55),

                        /// OR Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.black87, thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('OR', style: AppTextStyles.backBoldText.copyWith(fontWeight: FontWeight.w800)),
                            ),
                            Expanded(child: Divider(color: Colors.black87, thickness: 1)),
                          ],
                        ),

                        SizedBox(height: 38),

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
