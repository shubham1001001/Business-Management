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
                return Row(
                  children: List.generate(provider.balanceData.length, (index) {
                    final item = provider.balanceData[index];
                    return BalanceCard(label: item["label"]!, amount: item["amount"]!, icon: item["icon"]!);
                  }),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.018),

          Container(
            padding: AppSpacing.allPadding16,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: AppSpacing.kMediumRadius10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SalesInfo(title: "Sales order", amount: "₹ 00.00"),
                Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                SalesInfo(title: "Total Sales", amount: "₹ 00.00"),
                Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                SalesInfo(title: "Credit sales", amount: "₹ 00.00"),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),

          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  child: SvgPictureWidgets(svgString: "assets/svg_icons/quick_link.svg", color: AppColors.appBlackColor),
                ),
                AppSpacing.extraSmallWidth,
                Text("Quick link", style: AppTextStyles.title16),
              ],
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
