import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:sales/screens/vehicle_overview/vehicle_card_widgets.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../providers/vehicle_overview_provider.dart';

class VehicleOverviewScreen extends StatelessWidget {
  const VehicleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Overview', style: AppTextStyles.appBarBlackText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.addVehicleScreen);
            },
            child: const Text('Add Vehicle', style: AppTextStyles.appBarRedBoldText),
          ),
        ],
      ),
      body: Consumer<VehicleOverviewProvider>(
        builder: (BuildContext context, VehicleOverviewProvider provider, Widget? child) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.027),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    onChanged: provider.setSearchQuery,
                    decoration: InputDecoration(
                      hintStyle: AppTextStyles.textSize13,
                      hintText: 'Search terms',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPictureWidgets(svgString: "assets/svg_icons/filter_v.svg", size: 10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.kMediumRadius,
                        borderSide: BorderSide(color: AppColors.textFieldBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.kMediumRadius,
                        borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.5),
                      ),
                      border: OutlineInputBorder(borderRadius: AppSpacing.kMediumRadius),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.filteredVehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = provider.filteredVehicles[index];
                      return Padding(
                        padding: AppSpacing.allPadding5,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutesName.vehicleDetailsScreen);
                          },
                          child: VehicleCard(vehicle: vehicle),
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
}
