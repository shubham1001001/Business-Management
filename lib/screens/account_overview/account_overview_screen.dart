import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:shimmer/shimmer.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Overview"),
        leading: const BackButton(),
        actions: [Padding(padding: const EdgeInsets.only(right: 20), child: Image.asset("assets/icons/download_icons_b.png"))],
      ),
      body: Consumer<AccountOverviewProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: CustomScrollView(
              slivers: [
                // Table Header
                const SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Text("Assets", style: AppTextStyles.backBoldText)),
                      Expanded(flex: 2, child: Text("Debit", style: AppTextStyles.backBoldText)),
                      Expanded(flex: 2, child: Text("Credit", style: AppTextStyles.backBoldText)),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Shimmer or List
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
                              Expanded(flex: 4, child: Text(category, style: AppTextStyles.titleListTile)),
                              Expanded(flex: 2, child: Text(debitTotal.toStringAsFixed(0))),
                              const Expanded(flex: 2, child: Text("00.00")),
                            ],
                          ),
                          const SizedBox(height: 5),
                          ...items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutesName.accountDetailsScreen);
                                },
                                child: Row(
                                  children: [
                                    Expanded(flex: 4, child: Text(item.name, style: AppTextStyles.blueText)),
                                    Expanded(flex: 2, child: Text(item.debit.toStringAsFixed(0), style: AppTextStyles.appRedText)),
                                    Expanded(flex: 2, child: Text(item.credit.toStringAsFixed(2), style: AppTextStyles.appRedText)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }, childCount: provider.categorizedData.length),
                  ),

                // Divider under totals
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: SizedBox()),
                        Expanded(flex: 4, child: Divider(thickness: 1, color: AppColors.grey)),
                      ],
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 4)),

                // Total row
                if (!provider.isLoading)
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(flex: 4, child: Text("Total", style: AppTextStyles.backBoldText)),
                        Expanded(flex: 2, child: Text(provider.totalDebit.toStringAsFixed(0), style: AppTextStyles.backBoldText)),
                        Expanded(flex: 2, child: Text(provider.totalCredit.toStringAsFixed(2), style: AppTextStyles.backBoldText)),
                      ],
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
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
            const SizedBox(width: 8),
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
