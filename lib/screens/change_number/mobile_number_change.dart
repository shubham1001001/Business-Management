import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/Custom_message_widget.dart';
import '../../core/widgets/custom_auth_button.dart';
import '../../core/widgets/custom_textfield_numder.dart';
import '../../providers/auth_provider/number_change_provider/change_number_provider.dart';
import '../../routes/app_routes_name.dart';

class MobileNumberChange extends StatelessWidget {
  const MobileNumberChange({Key? key}) : super(key: key);

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(leadingWidth: 28, title: const Text("Change Number", style: AppTextStyles.appBarBlackText)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.largeHeight30,
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(height: 200, child: SvgPictureWidgets(svgString: "assets/svg_icons/change_number_hand.svg", size: 200.0)),
              ),

              /// This should now work correctly
              SizedBox(height: size.height * 0.21),

              Center(
                child: Column(
                  children: [
                    Text("Enter your phone number", style: AppTextStyles.appBlackText18.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FittedBox(
                        child: Text("+911234567890 is Your existing mobile number", style: AppTextStyles.greyText17.copyWith(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.smallHeight,
              Consumer<ChangeNumberProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: AppSpacing.rRadius20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.025),
                          MobileNumberField(errorText: provider.phone.isEmpty || provider.isPhoneValid ? null : 'Enter valid 10-digit number', onChanged: provider.updatePhone),
                          SizedBox(height: size.height * 0.025),
                          AppSpacing.mediumHeight16,
                          Center(
                            child: CustomAuthButton(
                              width: 185,
                              text: "Get OTP",
                              onTap: () {
                                if (provider.phone.length >= 10) {
                                  Navigator.of(context).pushNamed(AppRoutesName.changeNumberOtpscreen, arguments: provider.phone);
                                  CustomSnackbar.show(context, message: "Sent OTP", type: MessageType.success);
                                } else {
                                  CustomSnackbar.show(context, message: "Please Inter Mobile Number", type: MessageType.error);
                                }
                              },
                            ),
                          ),
                        ],
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
