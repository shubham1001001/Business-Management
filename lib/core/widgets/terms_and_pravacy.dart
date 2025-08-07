import 'package:flutter/cupertino.dart';
import 'package:sales/core/constants/text_styles.dart';

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
              style: AppTextStyles.robotoFontStyleText.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: '   |   '),
            TextSpan(
              text: 'Privacy policy',
              style: AppTextStyles.robotoFontStyleText.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
