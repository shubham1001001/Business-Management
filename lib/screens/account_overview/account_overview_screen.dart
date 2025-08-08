import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
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
        leadingWidth: 28,
        title: const Text("Account Overview", style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPictureWidgets(svgString: "assets/svg_icons/download_icon_svg.svg", size: 26.0),
          ),
        ],
      ),
      body: Consumer<AccountOverviewProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Assets",
                          style: AppTextStyles.backBoldTextW600.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 57), fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Debit",
                          style: AppTextStyles.backBoldTextW600.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 57), fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.end,
                          " Credit",
                          style: AppTextStyles.backBoldTextW600.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 57), fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: AppSpacing.mediumHeight16),

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
                              Expanded(
                                flex: 4,
                                child: Text(
                                  textAlign: TextAlign.start,
                                  "   $category",
                                  style: AppTextStyles.titleListTile.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 50), fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.8)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  debitTotal.toStringAsFixed(0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTextStyles.titleListTile.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 49), fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.8)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  "00.00",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTextStyles.titleListTile.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 49), fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.8)),
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.extraSmallHeight,

                          ...items.map(
                            (item) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutesName.accountDetailsScreen);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(flex: 1, child: Text("")),
                                        Expanded(
                                          flex: 9,
                                          child: Text(
                                            textAlign: TextAlign.start,
                                            item.name,
                                            style: AppTextStyles.blueBoldTextIndigo.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 52), color: Color(0xFF0000EE).withOpacity(0.8)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            item.debit.toStringAsFixed(0),
                                            style: AppTextStyles.appRedBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 54), color: AppColors.redColor.withOpacity(0.8), fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            item.credit.toStringAsFixed(2),
                                            style: AppTextStyles.appRedBoldText.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 54), color: AppColors.redColor.withOpacity(0.8), fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          AppSpacing.largeHeight31,
                        ],
                      );
                    }, childCount: provider.categorizedData.length),
                  ),

                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: SizedBox()),
                        Expanded(flex: 4, child: Divider(thickness: 1.8, color: AppColors.grey.withOpacity(0.2))),
                      ],
                    ),
                  ),

                SliverToBoxAdapter(child: AppSpacing.extraSmallWidth),

                // Totals
                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            textAlign: TextAlign.start,
                            "Total",
                            style: AppTextStyles.appBarBlackText18.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60), fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.8)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            textAlign: TextAlign.center,
                            provider.totalDebit.toStringAsFixed(0),
                            style: AppTextStyles.appBarBlackText18.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60), color: Colors.black87.withOpacity(0.8)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            textAlign: TextAlign.end,
                            provider.totalCredit.toStringAsFixed(2),
                            style: AppTextStyles.appBarBlackText18.copyWith(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 60), color: Colors.black87.withOpacity(0.8)),
                          ),
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
