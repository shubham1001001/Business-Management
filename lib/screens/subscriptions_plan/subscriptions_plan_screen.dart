import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/providers/subscription_plan_provider/Subscription_plan_provider.dart';

import '../../core/constants/svg_picture_widgets.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        title: const Text('Subscription Plan', style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                SvgPictureWidgets(svgString: "assets/svg_icons/info_icon.svg", color: AppColors.redColor, size: 20.0),
                SizedBox(width: 4),
                Text('Plan info', style: AppTextStyles.appBarRedBoldText16),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 64, vertical: 16),
                child: IntrinsicHeight(
                  // Ensures children like Divider stay at bottom if content is short
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.02),

                      Consumer<SubscriptionPlanProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/bluetik.png", height: size.height * 0.05),
                                  Expanded(child: Text('Your subscription is active', style: AppTextStyles.titleBold20W800)),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(provider.companyName, style: AppTextStyles.greyW800Text),
                              AppSpacing.extraSmallHeight,
                              Text("Company ID : ${provider.companyId}", style: AppTextStyles.greyBoldW500Text),

                              SizedBox(height: size.height * 0.02),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: RotatedBox(
                                      quarterTurns: 10,
                                      child: CircularProgressIndicator(value: provider.daysLeft / 15, strokeWidth: 6, valueColor: AlwaysStoppedAnimation<Color>(AppColors.proccessIndicatorColor), backgroundColor: Colors.grey.shade300),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text('${provider.daysLeft}', style: AppTextStyles.title16),
                                      const Text('Days left', style: AppTextStyles.textSize11W600),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: size.height * 0.025),

                      Consumer<SubscriptionPlanProvider>(
                        builder: (context, provider, child) {
                          return Container(
                            padding: EdgeInsets.all(size.width * 0.030),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.cardmainColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Plan name', style: AppTextStyles.greyBoldW500Text),
                                      AppSpacing.extraSmallHeight,
                                      Text(provider.planName, style: AppTextStyles.customButtonTextStyle),
                                      SizedBox(height: size.height * 0.04),
                                      const Text('Created on', style: AppTextStyles.greyBoldW500Text),
                                      AppSpacing.extraSmallHeight,
                                      Text(provider.createdOn, style: AppTextStyles.customButtonTextStyle),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Billing cycle', style: AppTextStyles.greyBoldW500Text),
                                      AppSpacing.extraSmallHeight,
                                      Text(provider.billingCycle, style: AppTextStyles.customButtonTextStyle),
                                      SizedBox(height: size.height * 0.04),
                                      const Text('Renewal on', style: AppTextStyles.greyBoldW500Text),
                                      AppSpacing.extraSmallHeight,
                                      Text(provider.renewalOn, style: AppTextStyles.customButtonTextStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // CustomButton(colors: AppColors.redColor, text: 'Manage subscription', onPressed: () {}),
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: 152,
                      //   height: 36,
                      //   decoration: BoxDecoration(borderRadius: AppSpacing.kMediumRadius, color: AppColors.redColor),
                      //   child: Text('Manage subscription', style: AppTextStyles.customButtonTextWhiteStyle),
                      // ),
                      // Replace your current button code with this:
                      FractionallySizedBox(
                        widthFactor: 0.45, // 50% of parent width
                        child: SizedBox(
                          height: 40, // Fixed height
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: AppColors.redColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Manage subscription', style: AppTextStyles.customButtonTextWhiteStyle),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            // Makes the left divider take available space
                            child: Divider(
                              color: Colors.grey[400],
                              thickness: 1, // Optional: Adjust thickness
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8), // Spacing around the text
                            child: Text("Need support", style: AppTextStyles.greyBoldW500Text),
                          ),
                          Expanded(
                            // Makes the right divider take available space
                            child: Divider(
                              color: Colors.grey[400],
                              thickness: 1, // Optional: Adjust thickness
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.mediumHeight16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/whts_app_4x.png", height: size.height * 0.05),
                          SizedBox(width: size.width * 0.018),
                          Container(color: Colors.grey[300], height: size.height * 0.04, width: 2),
                          SizedBox(width: size.width * 0.018),
                          Text("+91 8891900365", style: AppTextStyles.robotoFontStyleTextNormal),
                        ],
                      ),
                      Divider(color: Colors.grey[400]),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
