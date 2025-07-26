import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

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
        actions: [IconButton(icon: Image.asset("assets/icons/downloadIcon.png"), onPressed: () {})],
      ),
      body: Consumer<TripProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: AppSpacing.allPadding16,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.cardmainColor, borderRadius: BorderRadius.circular(15)),
                  width: size.width * 0.4,
                  child: Padding(
                    padding: AppSpacing.allPadding5,
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
                ),
                AppSpacing.mediumHeight16,
                Text('10 Unit', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                const Text('Total vehicle', style: AppTextStyles.greyText),
                const Divider(height: 32),
                _buildMetricRow('Opening stock qty', '320 trip'),
                _buildMetricRow('Total revenue', '\$ 1200.80'),
                _buildMetricRow('Average fuel efficiency', '5km / lit'),
                _buildMetricRow('Idle vehicles', '02 unit'),
                AppSpacing.mediumHeight16,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), elevation: 4),
                  onPressed: () {},
                  child: const Text('View vehicle summary'),
                ),
                AppSpacing.mediumHeight16,
                Expanded(
                  child: ListView.separated(
                    itemCount: provider.vehicleList.length,
                    separatorBuilder: (_, __) => AppSpacing.smallHeight10,
                    itemBuilder: (context, index) {
                      final vehicle = provider.vehicleList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: AppSpacing.kMediumRadius10,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
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
                            Text(vehicle.driverName, style: AppTextStyles.greyText),
                            AppSpacing.extraSmallHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Fuel intake', style: AppTextStyles.greyText),
                                    Text('${vehicle.fuelIntake} liters'),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Distance travelled', style: AppTextStyles.greyText),
                                    Text('${vehicle.distanceTravelled} KM'),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
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
          Text(label, style: AppTextStyles.greyText),
          Text(value, style: AppTextStyles.backBoldText),
        ],
      ),
    );
  }
}
