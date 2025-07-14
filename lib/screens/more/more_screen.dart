import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/widgets/app_header.dart';
import 'package:sales/routes/app_routes_name.dart';
import 'package:sales/screens/more/widgets/card_widget.dart';

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
                  Padding(
                    padding: EdgeInsets.only(left: screen.width * 0.03),
                    child: Text("Account Setting"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.ProfileInformations);
                    },
                    child: ListTile(leading: Icon(Icons.person_pin), title: Text("Profile Information"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.subscriptionPlanScreen);
                    },
                    child: ListTile(leading: Icon(Icons.star_border), title: Text("Subscription Plan"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ),
                ],
              ),
              CardWidget(
                child: [
                  Padding(
                    padding: EdgeInsets.only(left: screen.width * 0.03),
                    child: Text("Costing"),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(AppRoutesName.venderDetailScreen);
                    },
                    child: ListTile(leading: Icon(Icons.format_align_center_outlined), title: Text("Cost Center"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ),
                  ListTile(leading: Icon(Icons.star_border), title: Text("Dummy"), trailing: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
              CardWidget(
                child: [
                  Padding(
                    padding: EdgeInsets.only(left: screen.width * 0.03),
                    child: Text("Utilities"),
                  ),
                  ListTile(leading: Icon(Icons.backup_outlined), title: Text("Backup / Restore"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ListTile(leading: Icon(Icons.monetization_on), title: Text("Opening Balance"), trailing: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
              CardWidget(
                child: [
                  Padding(
                    padding: EdgeInsets.only(left: screen.width * 0.03),
                    child: Text("Other"),
                  ),
                  ListTile(leading: Icon(Icons.settings), title: Text("Settings"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ListTile(leading: Icon(Icons.notifications_none_outlined), title: Text("Notification"), trailing: Icon(Icons.keyboard_arrow_right)),
                  ListTile(leading: Icon(Icons.star_border), title: Text("My business"), trailing: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
