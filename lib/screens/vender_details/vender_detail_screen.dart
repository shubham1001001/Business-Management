import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/routes/app_routes_name.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/delete_confirmation_dialog_widget.dart';

class VenderDetailScreen extends StatelessWidget {
  const VenderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Details', style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 64, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              padding: AppSpacing.allPadding16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: AppSpacing.kMediumRadius,
                color: AppColors.cardmainColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Vendor name', style: TextStyle(color: AppColors.redColor, fontSize: 20))],
                      ),
                      Text("+91 8152369874", style: AppTextStyles.textSize16),
                      AppSpacing.mediumHeight16,
                      const Text('Payable', style: TextStyle(color: AppColors.greyText)),
                      Row(
                        children: [
                          Text("₹ ", style: TextStyle(fontSize: 20, color: AppColors.greyText)),
                          Text("00.00"),
                        ],
                      ),
                    ],
                  ),
                  // Right info
                  SizedBox(width: size.width * 0.2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPictureWidgets(svgString: "assets/svg_icons/edit_icon.svg", color: AppColors.appBlackColor, size: 20.0),
                          AppSpacing.largeWidth,
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => DeleteConfirmationDialog(onConfirm: () {}),
                              );
                            },
                            child: SvgPictureWidgets(svgString: "assets/svg_icons/delete_svg_icon.svg", size: 20.0),
                          ),
                          AppSpacing.largeWidth,
                          InkWell(
                            onTap: () async {
                              final selected = await showMenu<String>(
                                context: context,
                                position: RelativeRect.fromLTRB(1000, 170, 10, 100), // Adjust based on screen size
                                items: [_buildMenuItem('comment', Icons.comment, 'Comment'), _buildMenuItem('statement', Icons.receipt_long, 'Customer statement'), _buildMenuItem('lorem1', Icons.public, 'Lorem ipsum'), _buildMenuItem('lorem2', Icons.public, 'Lorem ipsum')],
                              );

                              // ✅ Check for null
                              if (selected != null) {
                                switch (selected) {
                                  case 'comment':
                                    Navigator.pushNamed(context, AppRoutesName.vendorTimelineScreen);
                                    break;
                                  case 'statement':
                                    // Handle statement
                                    break;
                                  // etc.
                                }
                              }
                            },
                            child: Icon(Icons.more_vert, size: 25),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),
                      // const Text('Outstanding', style: TextStyle(color: AppColors.greyText)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [_PaymentItem(title: "Outstanding", amount: "00.00")],
                      ),
                      // Row(
                      //   children: [
                      //     Text("₹ ", style: TextStyle(fontSize: 20, color: AppColors.greyText)),
                      //     Text("00.00"),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.025),

            Text("Address"),
            SizedBox(height: size.height * 0.01),
            Text("House no: 222, uphill,street - 45, majortown (po)Kottayam, 600015, Kerala", style: TextStyle(color: AppColors.greyText)),
            SizedBox(height: size.height * 0.01),
            Text("Description"),
            Text("is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'sstandard dummy text ever since the 1500s", style: TextStyle(color: AppColors.greyText)),
          ],
        ),
      ),
    );
  }
}

PopupMenuItem<String> _buildMenuItem(String value, IconData icon, String title) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 12),
        Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
      ],
    ),
  );
}

class _PaymentItem extends StatelessWidget {
  final String title;
  final String amount;

  const _PaymentItem({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(child: Text(title, style: AppTextStyles.textSize16)),
        AppSpacing.extraSmallHeight,
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              const TextSpan(text: "₹ "),
              TextSpan(
                text: amount,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
