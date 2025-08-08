import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_date_picker.dart';
import '../../core/widgets/custom_dropdown_widget.dart';
import '../../core/widgets/delete_confirmation_dialog_widget.dart';
import '../../providers/account_details/account_details_provider.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountDetailsProvider>(context, listen: false).fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dropItem = [DropdownMenuItem(value: TransactionFilter.today, child: Text("Today")), DropdownMenuItem(value: TransactionFilter.thisWeek, child: Text("This Week")), DropdownMenuItem(value: TransactionFilter.thisMonth, child: Text("This Month")), DropdownMenuItem(value: TransactionFilter.custom, child: Text("Custom"))];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 28,
        title: const Text("Account Details", style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
      ),
      body: Consumer<AccountDetailsProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 14),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const SizedBox(height: 12)),
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _infoCard(size: size),
                      AppSpacing.mediumHeight,
                      Positioned(bottom: -45, left: 0, right: 0, child: Center(child: _balanceCard(provider.balanceAmount, size))),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 66)),

                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Transaction", style: AppTextStyles.titleW700),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: SvgPictureWidgets(svgString: "assets/svg_icons/download_icon_svg.svg", size: 26.0),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: AppSpacing.mediumHeight16),
                SliverToBoxAdapter(
                  child: Consumer<AccountDetailsProvider>(
                    builder: (context, provider, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dropdown
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 45, // Smaller height
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),

                              child: CustomDropdown<TransactionFilter>(
                                isExpanded: false,
                                value: provider.selectedFilter,
                                items: dropItem,
                                onChanged: (filter) {
                                  if (filter != null) provider.setFilter(filter);
                                },
                              ),
                            ),
                          ),

                          AppSpacing.smallHeight,

                          // Custom Date Picker Row
                          if (provider.selectedFilter == TransactionFilter.custom)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  // FROM
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final picked = await CustomDatePicker.show(context: context, initialDate: provider.customFromDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                                        if (picked != null && provider.customToDate != null) {
                                          provider.setCustomRange(picked, provider.customToDate!);
                                        } else if (picked != null) {
                                          provider.setCustomRange(picked, picked);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.textFieldBorderColor),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 18, color: AppColors.textFieldBorderColor),
                                            const SizedBox(width: 6),
                                            Text(
                                              provider.customFromDate != null ? "${provider.customFromDate!.day.toString().padLeft(2, '0')}.${provider.customFromDate!.month.toString().padLeft(2, '0')}.${provider.customFromDate!.year}" : "From",
                                              style: AppTextStyles.greyTextW500.copyWith(fontWeight: FontWeight.w800, color: Colors.black26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      "To",
                                      style: AppTextStyles.backBoldText.copyWith(fontWeight: FontWeight.w800, color: Colors.black26.withOpacity(0.7)),
                                    ),
                                  ),
                                  // TO
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        final picked = await CustomDatePicker.show(context: context, initialDate: provider.customToDate ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                                        if (picked != null && provider.customFromDate != null) {
                                          provider.setCustomRange(provider.customFromDate!, picked);
                                        } else if (picked != null) {
                                          provider.setCustomRange(picked, picked);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.textFieldBorderColor),
                                          borderRadius: AppSpacing.kMediumRadius,
                                        ),

                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 18, color: AppColors.textFieldBorderColor),
                                            const SizedBox(width: 6),
                                            Text(
                                              provider.customToDate != null ? "${provider.customToDate!.day.toString().padLeft(2, '0')}.${provider.customToDate!.month.toString().padLeft(2, '0')}.${provider.customToDate!.year}" : "To",
                                              style: AppTextStyles.greyTextW500.copyWith(fontWeight: FontWeight.w800, color: Colors.black26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: AppSpacing.smallHeight),

                //  Table Header
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text("Asset name", style: AppTextStyles.appRedTextBold.copyWith(color: AppColors.redColor.withOpacity(0.9))),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Debit", style: AppTextStyles.appRedTextBold.copyWith(color: AppColors.redColor.withOpacity(0.9))),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Credit", style: AppTextStyles.appRedTextBold.copyWith(color: AppColors.redColor.withOpacity(0.9))),
                      ),
                    ],
                  ),
                ),

                SliverToBoxAdapter(child: AppSpacing.extraSmallHeight),

                // List or Shimmer
                provider.isLoading
                    ? SliverList(delegate: SliverChildBuilderDelegate((_, index) => _buildShimmerItem(), childCount: 3))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((_, index) {
                          final tx = provider.filteredTransactions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                index == 0 ? Divider(color: Colors.black26, thickness: 1.0) : SizedBox.shrink(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(tx.name, style: AppTextStyles.greyBoldText.copyWith(color: Colors.black87.withOpacity(0.8))),
                                          AppSpacing.smallHeight,
                                          Text(
                                            tx.date,
                                            style: AppTextStyles.greyTextW500.copyWith(fontWeight: FontWeight.w600, color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(tx.debit.toStringAsFixed(0), style: AppTextStyles.greyBoldText.copyWith(color: Colors.black87.withOpacity(0.8))),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(tx.credit.toStringAsFixed(2), style: AppTextStyles.greyBoldText.copyWith(color: Colors.black87.withOpacity(0.8))),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.black26, thickness: 1.0),
                              ],
                            ),
                          );
                        }, childCount: provider.filteredTransactions.length),
                      ),
                // Total Row
                if (!provider.isLoading) SliverToBoxAdapter(child: _buildTotalRow(provider)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, color: Colors.white),
                  const SizedBox(height: 4),
                  Container(height: 10, width: 60, color: Colors.white),
                ],
              ),
            ),

            AppSpacing.smallWidth,
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
            AppSpacing.smallWidth,
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({size}) {
    return Container(
      padding: AppSpacing.allPadding16,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),

        borderRadius: AppSpacing.kMediumRadius,

        color: AppColors.cardmainColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lorem ipsum', style: AppTextStyles.blackBoldText15W800.copyWith(fontSize: 18, color: Colors.black87.withOpacity(0.8))),
                  AppSpacing.extraSmallHeight,
                  Text("12.02.2025", style: AppTextStyles.textSize16),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.mediumHeight,
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => DeleteConfirmationDialog(
                          onConfirm: () {
                            Provider.of<AccountDetailsProvider>(context, listen: false).deleteAccount();
                          },
                        ),
                      );
                    },
                    child: SvgPictureWidgets(svgString: "assets/svg_icons/delete_svg_icon.svg", size: 20.0),
                  ),

                  AppSpacing.largeWidth24,

                  SvgPictureWidgets(svgString: "assets/svg_icons/edit_icon.svg", color: AppColors.appBlackColor, size: 20.0),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 0.075),
        ],
      ),
    );
  }

  Widget _balanceCard(double amount, size) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.kLargeRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2), // top shadow
              blurRadius: 6,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 3), // bottom shadow
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.19, vertical: 9),
          child: Column(
            children: [
              Text(
                "Balance amount",
                style: AppTextStyles.textSize.copyWith(fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.8)),
              ),
              AppSpacing.smallHeight10,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₹',
                      style: TextStyle(color: AppColors.redColor, fontSize: 22, fontFamily: 'OpenSans'), // Or your preferred style for ₹
                    ),
                    TextSpan(
                      text: ' ${amount.toStringAsFixed(0)}',
                      style: AppTextStyles.appRedText18Bold.copyWith(color: AppColors.redColor.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow(AccountDetailsProvider provider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: Text("")),
            Expanded(
              flex: 2,
              child: Text(provider.totalDebit.toStringAsFixed(0), style: AppTextStyles.appBarBlackText18.copyWith(color: Colors.black87.withOpacity(0.8), fontSize: 17)),
            ),
            Expanded(
              flex: 2,
              child: Text(provider.totalCredit.toStringAsFixed(2), style: AppTextStyles.appBarBlackText18.copyWith(color: Colors.black87.withOpacity(0.8), fontSize: 17)),
            ),
          ],
        ),
      ],
    );
  }
}
