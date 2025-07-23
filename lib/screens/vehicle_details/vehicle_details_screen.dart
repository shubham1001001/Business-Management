import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/vehicle_details/widgets/shimmer_widget.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../providers/vehicle_details/vehicle_details_provider.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<VehicleDetailsProvider>(context, listen: false).loadTripData();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final usableHeight = screenHeight - appBarHeight - statusBarHeight;
    return Scaffold(
      backgroundColor: AppColors.redColor,
      appBar: AppBar(
        title: const Text("Vehicle Details", style: AppTextStyles.appBarWhiteText),
        backgroundColor: AppColors.redColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<VehicleDetailsProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.redColor,
                  padding: AppSpacing.allPadding16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("KL 11 B 1040", style: AppTextStyles.whiteTextSemiBold20),
                              SizedBox(height: media.height * 0.014),
                              const Text("Vehicle name", style: AppTextStyles.whiteTextW400),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/icons/edit_icons.png", height: 25, width: 25),
                                  SizedBox(width: media.width * 0.1),
                                  Padding(padding: const EdgeInsets.only(right: 10), child: Image.asset("assets/icons/delete_icon.png", height: 25, width: 25)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: media.height * 0.038),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_infoText("Owner name", "Ramu"), _infoText("Contact number", "+91 8156066227"), _infoText("Category", "Lorem ipsum")]),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: AppSpacing.allPadding16,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppSpacing.kRadius25,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                label: const Text("Trip "),
                                showCheckmark: false,
                                padding: EdgeInsets.symmetric(horizontal: media.width * 0.14, vertical: media.height * 0.01),
                                selected: provider.isTripSelected,
                                onSelected: (val) => provider.toggleTab(true),
                                selectedColor: AppColors.redColor,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: provider.isTripSelected ? Colors.white : AppColors.appBlackColor, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppSpacing.kChipRadius,
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: media.width * 0.06),
                              ChoiceChip(
                                label: const Text("Vehicle"),
                                showCheckmark: false,
                                padding: EdgeInsets.symmetric(horizontal: media.width * 0.14, vertical: media.height * 0.01),
                                selected: !provider.isTripSelected,
                                onSelected: (val) => provider.toggleTab(false),
                                selectedColor: AppColors.redColor,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: !provider.isTripSelected ? Colors.white : AppColors.appBlackColor, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: media.height * 0.01),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 16),
                            child: Container(
                              width: 98,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: provider.selectedFilter,
                                  items: const [
                                    DropdownMenuItem(value: "Today", child: Text("Today")),
                                    DropdownMenuItem(value: "Week", child: Text("Week")),
                                    DropdownMenuItem(value: "Month", child: Text("Month")),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) provider.setFilter(val);
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  style: AppTextStyles.backBoldText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("RXX BB 40080050", style: AppTextStyles.backText),
                            SvgPictureWidgets(svgString: "assets/svg_icons/download_icon.svg", color: AppColors.redColor),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("12.02.2025 - 12.02.2025", style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      SizedBox(height: media.height * 0.038),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: media.width * 0.93,
                          height: media.height * 0.06,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: AppColors.headerTitleColor, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text("Delivery point", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: usableHeight * 0.5,
                        child: provider.isLoading
                            ? const ShimmerLoader()
                            : ListView.builder(
                                itemCount: provider.tripList.length,
                                itemBuilder: (context, index) {
                                  final item = provider.tripList[index];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 6,
                                              child: Text(item.deliveryPoint, textAlign: TextAlign.left, style: AppTextStyles.greyBoldText),
                                            ),
                                            Flexible(
                                              flex: 4,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: "₹ ", style: AppTextStyles.black87Text20),
                                                    TextSpan(text: "${item.amount}", style: AppTextStyles.backText),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(height: 0, thickness: 1, indent: 17, endIndent: 17, color: Colors.grey),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoText(String title, String value) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.white60BoldText14),
          SizedBox(height: 15),
          Text(value, style: AppTextStyles.whiteBoldText14),
        ],
      ),
    );
  }
}
