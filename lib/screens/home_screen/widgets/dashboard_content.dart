import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/home_screen/widgets/quick_link_scrollView.dart';
import 'package:sales/screens/home_screen/widgets/sales_info_widget.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/svg_picture_widgets.dart';
import '../../../providers/home_provider/home_provider.dart';
import 'balance_card_widgets.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(provider.balanceData.length, (index) {
                      final item = provider.balanceData[index];
                      return BalanceCard(label: item["label"]!, amount: item["amount"]!, icon: item["icon"]!);
                    }),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.013),

          Padding(
            padding: AppSpacing.allPadding5,
            child: Container(
              padding: AppSpacing.allPadding16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: AppSpacing.kMediumRadius10,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SalesInfo(title: "Sales order", amount: "00.00"),
                    AppSpacing.extraSmallWidth,
                    Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                    AppSpacing.extraSmallWidth,
                    SalesInfo(title: "Total Sales", amount: "00.00"),
                    AppSpacing.extraSmallWidth,
                    Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                    AppSpacing.extraSmallWidth,
                    SalesInfo(title: "Credit sales", amount: "00.00"),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),

          Padding(
            padding: AppSpacing.allPadding5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    child: SvgPictureWidgets(svgString: "assets/svg_icons/quick_link.svg", color: AppColors.appBlackColor),
                  ),
                  AppSpacing.extraSmallWidth,
                  Text("Quick link", style: AppTextStyles.titleBold16W700),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          // Quick Links
          AppSpacing.extraSmallHeight3,
          QuickLinkScrollView(),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
