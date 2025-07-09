import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/screens/otp_screen/widgets/otp_widgets.dart';

import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/app_header.dart';
import '../../providers/otp_provider/CountdownProvider.dart';
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
    final provider = Provider.of<CountdownProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppHeader(title: "Change Email", endicon: false),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: size.height * 0.4,
                // width: size.width,
                child: Image.asset("assets/images/change_numer_otp.png", fit: BoxFit.contain),
              ),
            ),

            // Dark overlay
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.53,
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
                              Navigator.of(context).pushNamed(AppRoutesName.home);
                            },
                            child: Container(
                              decoration: BoxDecoration(color: AppColors.grey100, borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(15.0), child: Icon(Icons.arrow_back, size: 20)),
                            ),
                          ),

                          Text('Enter your OTP here', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(width: 6),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Text('An OTP has been sent to ${widget.number}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: size.height * 0.025),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutesName.mobileNumberChangeScreen);
                        },
                        child: Text(
                          'Change Mobile number',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.redcolor),
                        ),
                      ),

                      SizedBox(height: size.height * 0.025),
                      // Mobile Input
                      OtpInputScreen(controllers: controllers),
                      SizedBox(height: size.height * 0.025),
                      // OTP Button
                      Center(
                        child: SizedBox(
                          width: size.width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              String otp = controllers.map((controller) => controller.text).join();
                              if (otp.length == 4) {
                                Navigator.of(context).pushNamed(AppRoutesName.home);
                                CustomSnackbar.show(context, message: "success", type: MessageType.success);
                                print(otp);
                              } else {
                                CustomSnackbar.show(context, message: "Please Inter OTP", type: MessageType.error);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redcolor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('OR')),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Resend OTP ",
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.redcolor),
                            ),
                            Text("in ${provider.remainingTime}s", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
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
    );
  }
}
