import 'package:flutter/material.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../routes/app_routes_name.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset("assets/images/signup_background.jpg", fit: BoxFit.cover),
            // Image.asset(
            //   'assets/images/bg.jpg', // Use your image path
            //   fit: BoxFit.cover,
            // ),
          ),
          // Dark overlay
          Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
          // Slogan
          Positioned(
            top: size.height * 0.2,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'B', style: AppTextStyles.headingBaskervVilleFontStyleTextBig),
                            TextSpan(text: 'RIDGING', style: AppTextStyles.headingBaskervVilleFontStyleText),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: ' M', style: AppTextStyles.headingBaskervVilleFontStyleTextBig),
                            TextSpan(text: 'ILES', style: AppTextStyles.headingBaskervVilleFontStyleText),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'W', style: AppTextStyles.headingBaskervVilleFontStyleText),
                        TextSpan(text: 'ITH', style: AppTextStyles.headingBaskervVilleFontStyleText20),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'M', style: AppTextStyles.headingBaskervVilleFontStyleTextBig),
                        TextSpan(text: 'EANING', style: AppTextStyles.headingBaskervVilleFontStyleText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade700, // Shadow color
                                offset: Offset(-2, -2), // Top-left direction
                                blurRadius: 6,
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutesName.signup);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0, // Important: remove default shadow
                              backgroundColor: Colors.transparent, // Let outer Container's color show
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: AppSpacing.kLargeRadius),
                            ),
                            child: const Text('Get Start'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
