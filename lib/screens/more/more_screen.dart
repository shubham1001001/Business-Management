import 'package:flutter/material.dart';
import 'package:sales/core/widgets/app_header.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "More", endicon: false, backbutton: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: []),
      ),
    );
  }
}
