import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/svg_picture_widgets.dart';
import '../../providers/vendor_comment_timeline/vendor_comment_timeline_provider.dart';

class VendorTimelineScreen extends StatelessWidget {
  const VendorTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment", style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
      ),
      body: Consumer<VendorCommentTimelineProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: AppSpacing.allPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    vendorHeader(name: provider.name, number: provider.number),
                    InkWell(
                      onTap: () async {},
                      child: SvgPictureWidgets(svgString: "assets/svg_icons/more_vert_icon.svg", size: 40.0),
                    ),
                  ],
                ),
                AppSpacing.largeHeight37,
                Flexible(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ListView.separated(
                                  itemCount: provider.events.length,
                                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                                  itemBuilder: (context, index) {
                                    final event = provider.events[index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.redColor, width: 3),
                                                borderRadius: AppSpacing.kSmallRadius,
                                              ),
                                            ),
                                            if (index != provider.events.length - 1) Container(width: 1, height: 68, color: Colors.black),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListView.separated(
                                itemCount: provider.events.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 0),
                                itemBuilder: (context, index) {
                                  final event = provider.events[index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(event.title, style: AppTextStyles.blackBoldText15),
                                      AppSpacing.smallHeight10,
                                      Text("${event.date}   ${event.time}", style: AppTextStyles.greyBoldText15),
                                      AppSpacing.largeHeight40,
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: AppSpacing.kSmallRadius,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: provider.controller,
                                onSubmitted: (_) => provider.sendMessage(context),
                                decoration: InputDecoration(
                                  hintStyle: AppTextStyles.greyTextW500,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  hintText: "Type to add a comment",
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    AppSpacing.extraSmallWidth,
                    InkWell(
                      onTap: () {
                        provider.sendMessage(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.redColor, borderRadius: BorderRadius.circular(25)),
                        height: 45,
                        width: 45,
                        child: SvgPictureWidgets(svgString: "assets/svg_icons/share_chat_icon.svg", size: 22.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget vendorHeader({name, number}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name, style: AppTextStyles.appBarRedBoldText),
      AppSpacing.smallHeight,
      Text(number, style: AppTextStyles.appBlackText18),
    ],
  );
}
