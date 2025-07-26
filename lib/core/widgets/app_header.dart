import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';

import '../constants/text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final endicon;
  final backbutton;
  const AppHeader({super.key, required this.title, this.endicon, this.backbutton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor, // or your desired color
      elevation: 0,

      automaticallyImplyLeading: false,
      title: Row(
        children: [
          backbutton
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const BackButton(color: Colors.black),
                )
              : SizedBox.shrink(),
          Flexible(
            child: Text(title, style: AppTextStyles.appBarBlackText, overflow: TextOverflow.ellipsis),
          ),
          const Spacer(),
          endicon
              ? const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.add, color: Colors.red),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
