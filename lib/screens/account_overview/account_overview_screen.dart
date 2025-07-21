import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/spacing.dart';
import '../../core/widgets/text_scale_widgets.dart';
import '../../providers/account_overview/account_overview_provider.dart';

class AccountOverviewScreen extends StatefulWidget {
  const AccountOverviewScreen({super.key});

  @override
  State<AccountOverviewScreen> createState() => _AccountOverviewScreenState();
}

class _AccountOverviewScreenState extends State<AccountOverviewScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountOverviewProvider>(context, listen: false).fetchAccountData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final screenWidth = size.width;
    final bool isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Overview"),
        leading: const BackButton(),
        actions: [Padding(padding: const EdgeInsets.only(right: 20), child: Image.asset("assets/icons/download_icons_b.png"))],
      ),
      body: Consumer<AccountOverviewProvider>(
        builder: (context, provider, _) {
          return Padding(
            // <<<<<<< Updated upstream
            //             padding: EdgeInsets.all(size.width * 0.04),
            //             child: CustomScrollView(
            //               slivers: [
            //                 // Table Header
            //                 const SliverToBoxAdapter(
            //                   child: Row(
            //                     children: [
            //                       Expanded(flex: 4, child: Text("Assets", style: AppTextStyles.backBoldText)),
            //                       Expanded(flex: 2, child: Text("Debit", style: AppTextStyles.backBoldText)),
            //                       Expanded(flex: 2, child: Text("Credit", style: AppTextStyles.backBoldText)),
            //                     ],
            //                   ),
            //                 ),
            //                 const SliverToBoxAdapter(child: SizedBox(height: 10)),
            //
            //                 // Shimmer or List
            // =======
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: CustomScrollView(
              slivers: [
                // Table Header
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Assets",
                          style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Debit",
                          style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Credit",
                          style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: AppSpacing.smallHeight10),

                // Loading Shimmer or Content
                if (provider.isLoading)
                  SliverList(delegate: SliverChildBuilderDelegate((_, index) => Column(children: List.generate(4, (_) => _shimmerRow())), childCount: 3))
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      final entry = provider.categorizedData.entries.elementAt(index);
                      final category = entry.key;
                      final items = entry.value;
                      final debitTotal = items.fold(0.0, (sum, e) => sum + e.debit);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // <<<<<<< Updated upstream
                              //                               Expanded(flex: 4, child: Text(category, style: AppTextStyles.titleListTile)),
                              //                               Expanded(flex: 2, child: Text(debitTotal.toStringAsFixed(0))),
                              //                               const Expanded(flex: 2, child: Text("00.00")),
                              //                             ],
                              //                           ),
                              //                           const SizedBox(height: 5),
                              // =======
                              Expanded(
                                flex: 4,
                                child: Text(
                                  category,
                                  style: AppTextStyles.titleListTile.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(flex: 2, child: Text(debitTotal.toStringAsFixed(0), overflow: TextOverflow.ellipsis, maxLines: 1)),
                              const Expanded(flex: 2, child: Text("00.00", overflow: TextOverflow.ellipsis, maxLines: 1)),
                            ],
                          ),
                          AppSpacing.extraSmallHeight,

                          ...items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutesName.accountDetailsScreen);
                                },
                                child: Row(
                                  children: [
                                    // <<<<<<< Updated upstream
                                    //                                     Expanded(flex: 4, child: Text(item.name, style: AppTextStyles.blueText)),
                                    //                                     Expanded(flex: 2, child: Text(item.debit.toStringAsFixed(0), style: AppTextStyles.appRedText)),
                                    //                                     Expanded(flex: 2, child: Text(item.credit.toStringAsFixed(2), style: AppTextStyles.appRedText)),
                                    // =======
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        item.name,
                                        style: AppTextStyles.blueText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        item.debit.toStringAsFixed(0),
                                        style: AppTextStyles.appRedText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        item.credit.toStringAsFixed(2),
                                        style: AppTextStyles.appRedText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 55)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // <<<<<<< Updated upstream
                          //                           const SizedBox(height: 10),
                          // =======
                          AppSpacing.smallHeight10,
                        ],
                      );
                    }, childCount: provider.categorizedData.length),
                  ),

                // <<<<<<< Updated upstream
                //                 // Divider under totals
                //                 const SliverToBoxAdapter(child: SizedBox(height: 8)),
                // =======
                // Divider
                const SliverToBoxAdapter(child: AppSpacing.mediumWidth),

                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: SizedBox()),
                        Expanded(flex: 4, child: Divider(thickness: 1, color: AppColors.grey)),
                      ],
                    ),
                  ),
                // <<<<<<< Updated upstream
                //                 const SliverToBoxAdapter(child: SizedBox(height: 4)),
                //
                //                 // Total row
                // =======
                SliverToBoxAdapter(child: AppSpacing.extraSmallWidth),

                // Totals
                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        // <<<<<<< Updated upstream
                        //                         const Expanded(flex: 4, child: Text("Total", style: AppTextStyles.backBoldText)),
                        //                         Expanded(flex: 2, child: Text(provider.totalDebit.toStringAsFixed(0), style: AppTextStyles.backBoldText)),
                        //                         Expanded(flex: 2, child: Text(provider.totalCredit.toStringAsFixed(2), style: AppTextStyles.backBoldText)),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        // =======
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Total",
                            style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(provider.totalDebit.toStringAsFixed(0), style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60))),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(provider.totalCredit.toStringAsFixed(2), style: AppTextStyles.backBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60))),
                        ),
                      ],
                    ),
                  ),
                SliverToBoxAdapter(child: AppSpacing.mediumHeight),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _shimmerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            Expanded(flex: 4, child: Container(height: 14, color: Colors.white)),

            AppSpacing.mediumWidth,
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
            AppSpacing.mediumWidth,
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
