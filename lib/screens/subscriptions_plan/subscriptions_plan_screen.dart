import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/providers/subscription_plan_provider/Subscription_plan_provider.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/CustomButton.dart';
import '../../core/widgets/text_scale_widgets.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plan'),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                SvgPictureWidgets(svgString: "assets/svg_icons/info_icon.svg", color: AppColors.redColor, size: 20.0),
                SizedBox(width: 4),
                Text('Plan info', style: AppTextStyles.appBarRedBoldText),
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
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/bluetik.png", height: size.height * 0.05),
                                  Text('Your subscription is active', style: AppTextStyles.title16),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(provider.companyName, style: AppTextStyles.greyBoldText),
                              Text("Company ID : ${provider.companyId}", style: AppTextStyles.greyText),

                              SizedBox(height: size.height * 0.02),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(value: provider.daysLeft / 30, strokeWidth: 6, valueColor: const AlwaysStoppedAnimation<Color>(Colors.red), backgroundColor: Colors.grey.shade300),
                                  ),
                                  Column(
                                    children: [
                                      Text('${provider.daysLeft}', style: AppTextStyles.title16),
                                      const Text('Days left', style: AppTextStyles.textSize11),
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
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.cardmainColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Plan name', style: AppTextStyles.greyText),
                                    Text(provider.planName, style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 45))),
                                    SizedBox(height: size.height * 0.02),
                                    const Text('Created on', style: AppTextStyles.greyText),
                                    Text(provider.createdOn),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Billing cycle', style: AppTextStyles.greyText),
                                    Text(provider.billingCycle, style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 45))),
                                    SizedBox(height: size.height * 0.02),
                                    const Text('Renewal on', style: AppTextStyles.greyText),
                                    Text(provider.renewalOn),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),
                      CustomButton(colors: AppColors.redColor, text: 'Manage subscription', onPressed: () {}),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.15, vertical: 12),
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColors.redColor,
                      //       padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1, vertical: 12),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      //       elevation: 4,
                      //     ),
                      //     child: const Text('Manage subscription'),
                      //   ),
                      // ),
                      const Spacer(),

                      Divider(color: Colors.grey[300]),
                      SizedBox(height: size.height * 0.01),
                      const Text("Need support", style: AppTextStyles.greyText),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/whatsapp.png", height: size.height * 0.05),
                          SizedBox(width: size.width * 0.018),
                          Container(color: Colors.grey[300], height: size.height * 0.04, width: 2),
                          SizedBox(width: size.width * 0.018),
                          const Text("+91 8891900365", style: AppTextStyles.redText),
                        ],
                      ),
                      Divider(color: Colors.grey[300]),
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
