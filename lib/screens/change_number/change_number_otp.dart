import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/otp_screen/widgets/otp_widgets.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../providers/otp_provider/countdown_provider.dart';
import '../../routes/app_routes_name.dart';

class ChangeNumberOtp extends StatefulWidget {
  final number;

  ChangeNumberOtp({super.key, required this.number});

  @override
  State<ChangeNumberOtp> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<ChangeNumberOtp> {
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
        appBar: AppBar(leadingWidth: 28, title: const Text("Change Number", style: AppTextStyles.appBarBlackText)),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: SizedBox(
                  height: size.height * 0.4,
                  // width: size.width,
                  child: SvgPictureWidgets(svgString: "assets/svg_icons/change_number_hand.svg", size: 230.0),
                ),
              ),
            ),

            // Dark overlay
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.49,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutesName.home);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SvgPictureWidgets(svgString: "assets/svg_icons/back_button_svg.svg", size: 43.0),
                            ),
                          ),
                          AppSpacing.largeWidth45,
                          Text(
                            'Enter your OTP here',
                            style: AppTextStyles.title.copyWith(fontSize: 15, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w800),
                          ),
                          AppSpacing.extraSmallHeight,
                        ],
                      ),
                      SizedBox(height: size.height * 0.018),
                      Text('An OTP has been sent to +91 8521589658', style: AppTextStyles.blackBoldText15.copyWith(color: Colors.black87.withOpacity(0.8))),
                      SizedBox(height: size.height * 0.025),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutesName.mobileNumberChangeScreen);
                        },
                        child: Text('Change Mobile number', style: AppTextStyles.redBoldText14),
                      ),

                      SizedBox(height: size.height * 0.041),
                      // Mobile Input
                      OtpInputScreen(controllers: controllers),
                      SizedBox(height: size.height * 0.046),
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

                      SizedBox(height: size.height * 0.041),
                      Consumer<CountdownProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2),
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
