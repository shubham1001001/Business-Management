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
        leadingWidth: 28,
        title: const Text('Vehicle Overview', style: AppTextStyles.appBarBlackText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.addVehicleScreen);
            },
            child: Text('Add Vehicle', style: AppTextStyles.appBarRedBoldText.copyWith(fontSize: 19, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
      body: Consumer<VehicleOverviewProvider>(
        builder: (BuildContext context, VehicleOverviewProvider provider, Widget? child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                AppSpacing.largeHeight,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    onChanged: provider.setSearchQuery,
                    decoration: InputDecoration(
                      hintStyle: AppTextStyles.textSize13.copyWith(fontWeight: FontWeight.w700, color: AppColors.greyText.withOpacity(0.6), fontSize: 14),
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
                AppSpacing.smallHeight,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: VehicleCard(vehicle: vehicle),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AppSpacing.smallHeight,
              ],
            ),
          );
        },
      ),
    );
  }
}
