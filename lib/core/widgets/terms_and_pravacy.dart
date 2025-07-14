import 'package:flutter/cupertino.dart';

import '../constants/colors.dart';

class TermsAndPravacy extends StatelessWidget {
  const TermsAndPravacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Terms and condition',
              style: TextStyle(color: AppColors.redColor, decoration: TextDecoration.underline),
            ),
            TextSpan(text: '   |   '),
            TextSpan(
              text: 'Privacy policy',
              style: TextStyle(color: AppColors.redColor, decoration: TextDecoration.underline),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
