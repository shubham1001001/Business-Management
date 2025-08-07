import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/app_header.dart';
import 'package:sales/screens/otp_screen/widgets/otp_widgets.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../providers/otp_provider/countdown_provider.dart';
import '../../routes/app_routes_name.dart';

class EmailChangeScreenOtp extends StatefulWidget {
  final number;

  EmailChangeScreenOtp({super.key, required this.number});

  @override
  State<EmailChangeScreenOtp> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<EmailChangeScreenOtp> {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    Provider.of<CountdownProvider>(context, listen: false).stopTimer();
    Provider.of<CountdownProvider>(context, listen: false).resetTimer();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<CountdownProvider>(context, listen: false).startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppHeader(title: "Change Number", endicon: false, backbutton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Background image
              SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.4,
                child: Image.asset("assets/images/emialIcon.png", fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 40),
              // Dark overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: AppSpacing.rRadius20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutesName.emaiChangeScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SvgPictureWidgets(svgString: "assets/svg_icons/back_button_svg.svg", size: 44.0),
                              ),
                            ),
                            AppSpacing.largeWidth50,
                            Text(
                              'Enter your OTP here',
                              style: AppTextStyles.title.copyWith(fontSize: 15, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w800),
                            ),
                            AppSpacing.extraSmallHeight,
                          ],
                        ),
                        SizedBox(height: size.height * 0.025),
                        Text('An OTP has been sent to newlorem@gmail.com', style: AppTextStyles.customButtonTextStyle),
                        SizedBox(height: size.height * 0.025),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutesName.mobileNumberChangeScreen);
                          },
                          child: Text('Change Email ID', style: AppTextStyles.redBoldText14),
                        ),

                        SizedBox(height: size.height * 0.025),
                        // Mobile Input
                        OtpInputScreen(controllers: controllers),
                        SizedBox(height: 45),
                        // OTP Button
                        Center(
                          child: CustomAuthButton(
                            text: "Submit",
                            onTap: () {
                              String otp = controllers.map((controller) => controller.text).join();
                              if (otp.length == 4) {
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.home, (route) => false);
                                CustomSnackbar.show(context, message: "success", type: MessageType.success);
                                print(otp);
                              } else {
                                CustomSnackbar.show(context, message: "Please Inter OTP", type: MessageType.error);
                              }
                            },
                          ),
                        ),
                        AppSpacing.largeHeight30,
                        Consumer<CountdownProvider>(
                          builder: (context, provider, child) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Resend OTP ", style: AppTextStyles.appLightRedBoldText),
                                  Text("in ${provider.remainingTime}s", style: AppTextStyles.blackBoldText13),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.025),
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
