import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/core/widgets/app_header.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:sales/screens/more/widgets/card_widget.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/svg_picture_widgets.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppHeader(title: "More", endicon: false, backbutton: false),
      body: Padding(
        padding: AppSpacing.allPadding8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardWidget(
                child: [
                  Text("Account Setting", style: AppTextStyles.greyBoldText),
                  AppSpacing.extraSmallHeight,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.ProfileInformations);
                    },
                    child: ListTile(
                      contentPadding: EdgeInsetsGeometry.all(0),
                      minLeadingWidth: 0,
                      minTileHeight: 19,
                      leading: SvgPictureWidgets(svgString: "assets/svg_icons/profile_icon.svg", color: AppColors.appBlackColor),
                      title: Text("Profile Information", style: AppTextStyles.openSansSemiBold),
                      trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                    ),
                  ),
                  AppSpacing.extraSmallHeight,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.subscriptionPlanScreen);
                    },
                    child: ListTile(
                      contentPadding: EdgeInsetsGeometry.all(0),
                      minLeadingWidth: 0,
                      minTileHeight: 19,
                      leading: SvgPictureWidgets(svgString: "assets/svg_icons/star_icon.svg", color: AppColors.appBlackColor),
                      title: Text("Subscription Plan", style: AppTextStyles.openSansSemiBold),
                      trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                    ),
                  ),
                ],
              ),
              CardWidget(
                child: [
                  Text("Costing", style: AppTextStyles.greyBoldText),
                  AppSpacing.extraSmallHeight,
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(AppRoutesName.venderDetailScreen);
                    },
                    child: ListTile(
                      contentPadding: EdgeInsetsGeometry.all(0),
                      minLeadingWidth: 0,
                      minTileHeight: 19,
                      leading: SvgPictureWidgets(svgString: "assets/svg_icons/cost_center_icon.svg", color: AppColors.appBlackColor),
                      title: Text("Cost Center", style: AppTextStyles.openSansSemiBold),
                      trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                    ),
                  ),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/cost_center_icon.svg", color: AppColors.appBlackColor),
                    title: Text("Dummy", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                ],
              ),
              CardWidget(
                child: [
                  Text("Utilities", style: AppTextStyles.greyBoldText),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/backup_icon.svg", color: AppColors.appBlackColor, size: 15.0),
                    title: Text("Backup / Restore", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/doller_icon.svg", color: AppColors.appBlackColor),
                    title: Text("Opening Balance", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                ],
              ),
              CardWidget(
                child: [
                  Text("Other", style: AppTextStyles.greyBoldText),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/setting_icon.svg", color: AppColors.appBlackColor),
                    title: Text("Settings", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/notification_icon.svg", color: AppColors.appBlackColor),
                    title: Text("Notification", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                  AppSpacing.extraSmallHeight,
                  ListTile(
                    contentPadding: EdgeInsetsGeometry.all(0),
                    minLeadingWidth: 0,
                    minTileHeight: 19,
                    leading: SvgPictureWidgets(svgString: "assets/svg_icons/my business.svg", color: AppColors.appBlackColor),
                    title: Text("My business", style: AppTextStyles.openSansSemiBold),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.greyLight),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
