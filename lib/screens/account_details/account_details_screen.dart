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
      appBar: AppBar(title: const Text("Account Details"), leading: const BackButton()),
      body: Consumer<AccountDetailsProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const SizedBox(height: 12)),
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _infoCard(size: size),
                      Positioned(bottom: -25, left: 0, right: 0, child: Center(child: _balanceCard(provider.balanceAmount, size))),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),

                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Transaction", style: AppTextStyles.title),
                      Padding(padding: const EdgeInsets.only(right: 20), child: Image.asset("assets/icons/download_icons_b.png")),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 5)),
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
                            Row(
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
                                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                                      child: Row(children: [const Icon(Icons.calendar_today, size: 18), const SizedBox(width: 6), Text(provider.customFromDate != null ? "${provider.customFromDate!.day.toString().padLeft(2, '0')}.${provider.customFromDate!.month.toString().padLeft(2, '0')}.${provider.customFromDate!.year}" : "From")]),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("To")),
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

                                      decoration: BoxDecoration(border: Border.all(), borderRadius: AppSpacing.kMediumRadius),

                                      child: Row(children: [const Icon(Icons.calendar_today, size: 18), const SizedBox(width: 6), Text(provider.customToDate != null ? "${provider.customToDate!.day.toString().padLeft(2, '0')}.${provider.customToDate!.month.toString().padLeft(2, '0')}.${provider.customToDate!.year}" : "To")]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: AppSpacing.smallHeight),

                //  Table Header
                const SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Text("Asset name", style: AppTextStyles.appRedText)),
                      Expanded(flex: 2, child: Text("Debit", style: AppTextStyles.appRedText)),
                      Expanded(flex: 2, child: Text("Credit", style: AppTextStyles.appRedText)),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tx.name),
                                      Text(tx.date, style: AppTextStyles.textSize11),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 2, child: Text(tx.debit.toStringAsFixed(0))),
                                Expanded(flex: 2, child: Text(tx.credit.toStringAsFixed(2))),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lorem ipsum', style: AppTextStyles.blackBoldText15),
                  Text("12.02.2025", style: AppTextStyles.textSize16),
                ],
              ),
              Row(
                children: [
                  AppSpacing.mediumHeight,

                  IconButton(
                    icon: Image.asset("assets/icons/delete_icon2.png", width: 20),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => DeleteConfirmationDialog(
                          onConfirm: () {
                            Provider.of<AccountDetailsProvider>(context, listen: false).deleteAccount();
                          },
                        ),
                      );
                    },
                  ),

                  AppSpacing.mediumHeight,

                  SvgPictureWidgets(svgString: "assets/svg_icons/edit_icon.svg", color: AppColors.appBlackColor, size: 20.0),
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 0.06),
        ],
      ),
    );
  }

  Widget _balanceCard(double amount, size) {
    return Center(
      child: Card(
        elevation: 6,

        shape: RoundedRectangleBorder(borderRadius: AppSpacing.kSmallRadius),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: 12),
          child: Column(
            children: [
              const Text("Balance amount", style: AppTextStyles.textSize13),
              const SizedBox(height: 4),
              Text("₹ ${amount.toStringAsFixed(0)}", style: AppTextStyles.appRedText18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow(AccountDetailsProvider provider) {
    return Column(
      children: [
        const Divider(thickness: 1),
        Row(
          children: [
            const Expanded(flex: 4, child: Text("")),
            Expanded(flex: 2, child: Text(provider.totalDebit.toStringAsFixed(0), style: AppTextStyles.backBoldText)),
            Expanded(flex: 2, child: Text(provider.totalCredit.toStringAsFixed(2), style: AppTextStyles.backBoldText)),
          ],
        ),
      ],
    );
  }
}
