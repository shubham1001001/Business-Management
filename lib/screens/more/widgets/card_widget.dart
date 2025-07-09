import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screen.width * 0.03),
              child: Text("Account Setting"),
            ),
            ListTile(leading: Icon(Icons.person_pin), title: Text("Profile Information"), trailing: Icon(Icons.keyboard_arrow_right)),
            ListTile(leading: Icon(Icons.star_border), title: Text("Subscription Plan"), trailing: Icon(Icons.keyboard_arrow_right)),
          ],
        ),
      ),
    );
  }
}
