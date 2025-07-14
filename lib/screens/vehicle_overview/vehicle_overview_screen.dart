import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/vehicle_overview/vehicle_card_widgets.dart';

import '../../providers/vehicle_overview_provider.dart';

class VehicleOverviewScreen extends StatelessWidget {
  const VehicleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Overview'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Add Vehicle', style: AppTextStyles.appBarRedText),
          ),
        ],
      ),
      body: Consumer<VehicleOverviewProvider>(
        builder: (BuildContext context, VehicleOverviewProvider provider, Widget? child) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.027),
            child: Column(
              children: [
                TextField(
                  onChanged: provider.setSearchQuery,
                  decoration: InputDecoration(
                    hintText: 'Search terms',
                    suffixIcon: Image.asset("assets/icons/Vector (3).png"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                        child: VehicleCard(vehicle: vehicle),
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
