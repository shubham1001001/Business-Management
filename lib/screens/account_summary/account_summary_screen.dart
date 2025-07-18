import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/text_scale_widgets.dart';
import '../../models/account_summry_model.dart';
import '../../providers/account_summary_provider/account_summary_provider.dart';

class AccountSummaryScreen extends StatelessWidget {
  const AccountSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Summary'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.addAccountScreen);
            },
            child: const Text('Add Account', style: AppTextStyles.appRedText),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.025),
        child: Consumer<AccountSummaryProvider>(
          builder: (context, provider, _) {
            return Container(
              padding: EdgeInsets.all(size.width * 0.030),
              decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: AppSpacing.kMediumRadius10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.open_in_new, color: AppColors.redColor)],
                    ),
                    _buildSection('Assets', provider.assets, isMobile, "Debit", "Credit", size.height, size.width, context),
<<<<<<< Updated upstream
                    const SizedBox(height: 16),
                    _buildSection('Liabilities', provider.liabilities, isMobile, '', '', size.height, size.width, context),
                    const SizedBox(height: 16),
=======
                    AppSpacing.mediumHeight16,
                    _buildSection('Liabilities', provider.liabilities, isMobile, '', '', size.height, size.width, context),
                    AppSpacing.mediumHeight16,
>>>>>>> Stashed changes
                    _buildSection('Income', provider.income, isMobile, '', '', size.height, size.width, context),
                    SizedBox(height: size.height * 0.04),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<AccountSummaryItem> items, bool isMobile, Debit, Credit, size, width, context) {
    double totalDebit = items.fold(0, (sum, item) => sum + item.debit);
    double totalCredit = items.fold(0, (sum, item) => sum + item.credit);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: AppColors.appBackColor, fontWeight: FontWeight.bold, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                  ), //
                  SizedBox(width: width * 0.37),
                  // Expanded(flex: 2, child: Text('')),
                  Expanded(
                    child: Text(
                      Debit,
                      style: TextStyle(color: AppColors.appBackColor, fontWeight: FontWeight.bold, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Credit,
                      style: TextStyle(color: AppColors.appBackColor, fontWeight: FontWeight.bold, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size * 0.01),
              Row(children: []),
              SizedBox(height: size * 0.01),
              ...items.map(
                (e) => Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        e.title,
                        style: TextStyle(color: AppColors.appBackColor, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.debit.toStringAsFixed(2),
                        style: TextStyle(color: AppColors.appBackColor, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.credit.toStringAsFixed(2),
                            style: TextStyle(color: AppColors.appBackColor, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size * 0.01),
              Row(
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: Text(
                      totalDebit.toStringAsFixed(2),
                      style: TextStyle(color: AppColors.appBackColor, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      totalCredit.toStringAsFixed(2),
                      style: TextStyle(color: AppColors.appBackColor, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutesName.accountOverviewScreen);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: size * 0.07),
                  child: Container(
<<<<<<< Updated upstream
                    height: 30, //size * 0.05,
                    width: 30, //width * 0.06,
=======
                    padding: AppSpacing.allPadding8,
                    // height: 30, //size * 0.05,
                    // width: 30, //width * 0.06,
>>>>>>> Stashed changes
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(17)),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 15), //size * 0.02
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
