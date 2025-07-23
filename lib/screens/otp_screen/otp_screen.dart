import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/terms_and_pravacy.dart';
import 'package:sales/screens/otp_screen/widgets/otp_widgets.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../providers/otp_provider/countdown_provider.dart';
import '../../routes/app_routes_name.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
        body: Stack(
          children: [
            // Background image
            SizedBox(
              height: size.height * 0.50,
              width: size.width,
              child: Image.asset("assets/images/signup_background.jpg", fit: BoxFit.cover),
            ),
            // Dark overlay
            Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
            // Slogan
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.05,
              child: Text('Bridging miles with\nmeaning', style: AppTextStyles.heading1FontStyleText),
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
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutesName.signup);
                            },
                            child: SvgPictureWidgets(svgString: "assets/svg_icons/back_button_svg.svg", size: 50.0),
                          ),

                          Text('Enter your OTP here', style: AppTextStyles.title),
                          AppSpacing.extraSmallHeight,
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Text('An OTP has been sent to +91 8521589658', style: AppTextStyles.blackBoldText15),
                      SizedBox(height: size.height * 0.025),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutesName.mobileNumberChangeScreen);
                        },
                        child: Text('Change Mobile number', style: AppTextStyles.redBoldText14),
                      ),

                      SizedBox(height: size.height * 0.025),
                      // Mobile Input
                      OtpInputScreen(controllers: controllers),
                      SizedBox(height: size.height * 0.025),
                      // OTP Button
                      CustomAuthButton(
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

                      SizedBox(height: size.height * 0.025),
                      Consumer<CountdownProvider>(
                        builder: (context, provider, child) {
                          return Center(
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
                      // Google Sign-in
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
                      SizedBox(height: size.height * 0.05),
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
