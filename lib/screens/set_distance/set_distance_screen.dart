import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/text_styles.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../core/widgets/text_scale_widgets.dart';
import '../../providers/set_distance/set_distance_provider.dart';
import '../pricing_preference/widgets/bottom_select_sheet_widget.dart';

class SetDistanceScreen extends StatefulWidget {
  @override
  State<SetDistanceScreen> createState() => _SetDistanceScreenState();
}

class _SetDistanceScreenState extends State<SetDistanceScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SetDistanceProvider>(context, listen: false).loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final usableHeight = screenHeight - appBarHeight - statusBarHeight;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Distance", style: AppTextStyles.appBarBlackText),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Add distance", style: AppTextStyles.appBarRedBoldText),
          ),
        ],
      ),
      body: Padding(
        padding: AppSpacing.allPadding12,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.mediumHeight16,
              _buildFeetSelector(context),
              AppSpacing.mediumHeight16,
              _buildDropdowns(),
              AppSpacing.mediumHeight16,
              _buildTableHeaders(),
              AppSpacing.mediumHeight16,
              Consumer<SetDistanceProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) return _buildShimmerList();
                  if (provider.distanceList.isEmpty) return const Center(child: Text("No Data"));
                  return SizedBox(
                    height: usableHeight * 0.5,
                    child: ListView.separated(
                      itemCount: provider.distanceList.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, index) {
                        final item = provider.distanceList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("", textAlign: TextAlign.left, style: AppTextStyles.boldText),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(item.deliveryPoint, textAlign: TextAlign.left, style: AppTextStyles.boldText),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(item.distance, textAlign: TextAlign.center, style: AppTextStyles.boldText),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(item.amount, textAlign: TextAlign.center, style: AppTextStyles.boldText),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeetSelector(BuildContext context) {
    final options = ['14 feet', '16 feet', '21 feet', '35 feet'];
    return Consumer<SetDistanceProvider>(
      builder: (context, provider, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: AppSpacing.kRadius25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options.map((e) {
              final selected = provider.selectedFeet == e;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      chipTheme: Theme.of(context).chipTheme.copyWith(
                        shape: RoundedRectangleBorder(borderRadius: AppSpacing.kChipRadius),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    child: ChoiceChip(
                      selectedShadowColor: AppColors.redColor,
                      showCheckmark: false,
                      label: Text(e, style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 50))),
                      selected: selected,
                      onSelected: (_) => provider.setSelectedFeet(e),
                      selectedColor: AppColors.redColor,
                      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildDropdowns() {
    return Consumer<SetDistanceProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Collection point", style: AppTextStyles.greyBoldW500Text),
            AppSpacing.smallHeight10,
            SizedBox(
              height: 50,
              child: CustomInputField(
                isEditable: true,
                keyboardType: TextInputType.text,
                hintText: 'Collection point',
                prefixText: '',
                isRequired: true, //
                errorText: null,
                onChanged: (value) {},
              ),
            ),
            AppSpacing.mediumHeight16,
            Text("delivery point", style: AppTextStyles.greyBoldW500Text),
            AppSpacing.smallHeight10,
            _buildSelectField(context, " delivery point", provider.selectedDeliveryPoint, provider.deliveryPoint, provider.setDeliveryPoint),

            AppSpacing.smallHeight10,
          ],
        );
      },
    );
  }

  Widget _buildTableHeaders() {
    return Row(
      children: const [
        Expanded(
          flex: 5,
          child: Text("Delivery point", style: AppTextStyles.greyBoldText, textAlign: TextAlign.center),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 3,
          child: Text("Distance", style: AppTextStyles.greyBoldText, textAlign: TextAlign.start),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: Text("Amount", style: AppTextStyles.greyBoldText, textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Expanded(flex: 4, child: Container(height: 20, color: Colors.white)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Container(height: 20, color: Colors.white)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Container(height: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSelectField(BuildContext context, String title, String? value, List<String> options, Function(String) onSelected) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: AppSpacing.rSmallRadius)),
        builder: (_) => BottomSelectSheetPricing(title: title, options: options, onSelect: onSelected, type: "Apply"),
      );
    },
    child: Container(
      height: 50,
      // Smaller height
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldBorderColor),
        borderRadius: AppSpacing.kMediumRadius,
        color: Colors.white,
      ),
      child: Text(value ?? "Select $title", style: AppTextStyles.greyText),
    ),
  );
}
