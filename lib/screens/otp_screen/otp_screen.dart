import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/terms_and_pravacy.dart';
import 'package:sales/screens/otp_screen/widgets/otp_widgets.dart';

import '../../core/widgets/CustomButton.dart';
import '../../core/widgets/Custom_message_widget.dart';
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
              height: size.height,
              width: size.width,
              child: Image.network("https://images.unsplash.com/photo-1536152470836-b943b246224c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5hdHVyZSUyMHZzJTIwbnVydHVyZXxlbnwwfHwwfHx8MA%3D%3D", fit: BoxFit.cover),
              // Image.asset(
              //   'assets/images/bg.jpg', // Use your image path
              //   fit: BoxFit.cover,
              // ),
            ),
            // Dark overlay
            Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
            // Slogan
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.05,
              child: Text('Bridging miles with\nmeaning', style: AppTextStyles.white70BoldText20),
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
                            child: Container(
                              decoration: BoxDecoration(color: AppColors.grey100, borderRadius: BorderRadius.all(AppSpacing.rRadius20)),
                              child: Padding(padding: AppSpacing.allPadding16, child: Icon(Icons.arrow_back, size: 20)),
                            ),
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
                      CustomButton(
                        colors: AppColors.redColor,
                        text: 'Submit',
                        onPressed: () {
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
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('OR')),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      Consumer<CountdownProvider>(
                        builder: (context, provider, child) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Resend OTP ", style: AppTextStyles.appRedBoldText13),
                                Text("in ${provider.remainingTime}s", style: AppTextStyles.blackBoldText13),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.025),
                      // Google Sign-in
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          label: Padding(padding: AppSpacing.allPadding8, child: Image.asset("assets/images/googleSign.png")),
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
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
