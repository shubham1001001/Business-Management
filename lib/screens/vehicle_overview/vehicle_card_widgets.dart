import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../models/vehicle_overview_model.dart';

class VehicleCard extends StatelessWidget {
  final VehicleOverviewModel vehicle;
  const VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final availableWidth = MediaQuery.of(context).size.width - MediaQuery.of(context).padding.horizontal - 20;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardClip,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(15), bottomLeft: Radius.circular(12)),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: AppSpacing.allPadding10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vehicle.vehicleNo, style: AppTextStyles.redW800Text),

                    Row(
                      children: [
                        const Icon(Icons.fiber_manual_record, size: 10, color: Colors.grey),
                        AppSpacing.extraSmallWidth,
                        Text(vehicle.distance, style: AppTextStyles.textSize13),
                      ],
                    ),
                  ],
                ),
                AppSpacing.mediumHeight16,
                Row(
                  children: [
                    SizedBox(
                      width: availableWidth / 2,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_labelText("Vehicle name", vehicle.name)]),
                    ),
                    SizedBox(
                      width: availableWidth / 2.8,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_labelText("Basic capacity", vehicle.capacity)]),
                    ),
                  ],
                ),
                AppSpacing.mediumHeight16,
                Row(
                  children: [
                    SizedBox(
                      width: availableWidth / 2,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_labelText("Lorem ipsum", vehicle.description)]),
                    ),
                    SizedBox(
                      width: availableWidth / 2.8,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_labelText("Category", vehicle.category)]),
                    ),
                  ],
                ),
                AppSpacing.extraSmallHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.greySmallW600),
        AppSpacing.extraSmallHeight,
        Text(value, style: AppTextStyles.titleListTile),
      ],
    );
  }
}
