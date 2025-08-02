import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_dropdown_widget.dart';
import '../../providers/trip_provider/trip_provider.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Summary', style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: SvgPictureWidgets(svgString: "assets/svg_icons/download_icon_svg.svg", size: 26.0, color: AppColors.redColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<TripProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: AppSpacing.allPadding16,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: BorderRadius.circular(15)),
                  width: size.width * 0.4,
                  child: CustomDropdown<String>(
                    isExpanded: false,
                    value: provider.selectedMonth,
                    items: provider.months.map((month) => DropdownMenuItem(value: month, child: Text(month))).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<TripProvider>().changeMonth(value);
                      }
                    },
                  ),
                ),
                AppSpacing.mediumHeight16,
                Text('10 Unit', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                const Text('Total vehicle', style: AppTextStyles.greyBoldText17),
                const Divider(height: 32),
                _buildMetricRow('Opening stock qty', '320 trip'),
                _buildMetricRow('Total revenue', '\$ 1200.80'),
                _buildMetricRow('Average fuel efficiency', '5km / lit'),
                _buildMetricRow('Idle vehicles', '02 unit'),
                AppSpacing.mediumHeight16,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.kMediumRadius),
                  ),
                  onPressed: () {},
                  child: Text('View vehicle summary', style: AppTextStyles.whiteTextW800),
                ),
                AppSpacing.mediumHeight16,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: AppSpacing.kMediumRadius10,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ListView.separated(
                      itemCount: provider.vehicleList.length,
                      separatorBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        child: SizedBox(child: Divider(color: Colors.grey)),
                      ),

                      itemBuilder: (context, index) {
                        final vehicle = provider.vehicleList[index];
                        return Padding(
                          padding: AppSpacing.allPadding12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(vehicle.vehicleNo, style: AppTextStyles.backBoldText),

                                  Text('000${index + 1}', style: AppTextStyles.greyText),
                                ],
                              ),
                              AppSpacing.extraSmallHeight,
                              Text(vehicle.driverName, style: AppTextStyles.greyText),
                              AppSpacing.smallHeight10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Fuel intake', style: AppTextStyles.greyText),
                                      AppSpacing.extraSmallHeight,
                                      Text('${vehicle.fuelIntake} liters'),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Distance travelled', style: AppTextStyles.greyText),
                                      AppSpacing.extraSmallHeight,
                                      Text('${vehicle.distanceTravelled} KM'),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: AppSpacing.kMediumRadius),
                                      backgroundColor: AppColors.redColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                    ),
                                    onPressed: () {},
                                    child: const Text('View'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.greyBoldText17),
          Text(value, style: AppTextStyles.blackTextW800),
        ],
      ),
    );
  }
}
