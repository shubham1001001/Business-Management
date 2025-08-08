import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../routes/app_routes_name.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset("assets/images/signup_background.jpg", fit: BoxFit.cover),
            // Image.asset(
            //   'assets/images/bg.jpg', // Use your image path
            //   fit: BoxFit.cover,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset('assets/svg_icons/warning.svg', width: 24, height: 24, fit: BoxFit.contain, color: Colors.white),
          ),
          // Dark overlay
          Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
          // Slogan
          Positioned(
            top: size.height * 0.2,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'B', style: AppTextStyles.headingBaskervVilleFontStyleTextBig.copyWith(fontSize: 45)),
                            TextSpan(text: 'RIDGING', style: AppTextStyles.headingBaskervVilleFontStyleText.copyWith(fontSize: 31)),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: ' M', style: AppTextStyles.headingBaskervVilleFontStyleTextBig.copyWith(fontSize: 45)),
                            TextSpan(text: 'ILES', style: AppTextStyles.headingBaskervVilleFontStyleText.copyWith(fontSize: 31)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'W', style: AppTextStyles.headingBaskervVilleFontStyleText.copyWith(fontSize: 25)),
                        TextSpan(text: 'ITH', style: AppTextStyles.headingBaskervVilleFontStyleText20.copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'M', style: AppTextStyles.headingBaskervVilleFontStyleTextBig.copyWith(fontSize: 45)),
                        TextSpan(text: 'EANING', style: AppTextStyles.headingBaskervVilleFontStyleText.copyWith(fontSize: 31)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White card
          Positioned(
            top: size.height * 0.81,
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutesName.signup);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                  child: CustomPaint(
                    painter: InnerShadowPainter(blur: 5, color: Colors.white, offset: const Offset(2, 4), radius: 5), //const Color(0xFFFFFFFF)
                    child: Container(
                      width: 227,
                      height: 41,
                      child: Stack(
                        children: [
                          // Gradient background with rounded corners
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: AppSpacing.kLargeRadius,
                              gradient: LinearGradient(
                                begin: Alignment(-1.0, -1.0), // Left-Center-Top
                                end: Alignment(-1.0, 1.0),
                                colors: [
                                  Colors.grey.shade800,
                                  Color(0xFF3A3A3A), //Color(0xFF3A3A3A), // Lighter at top (20%)
                                  Color(0xFF2E2E2E), // Full dark at bottom
                                ],
                                stops: [0.1, 0.2, 1.0],
                              ),
                            ),
                          ),
                          // Inner shadow using blend mode
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: AppSpacing.kLargeRadius,
                              boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 0)],
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: AppSpacing.kLargeRadius,
                              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black12, Colors.transparent]),
                            ),
                          ),
                          // Button label centered
                          Center(child: Text('Get start', style: AppTextStyles.customButtonTextWhiteStyle)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final double blur;
  final Color color;
  final Offset offset;
  final double radius;

  InnerShadowPainter({required this.blur, required this.color, required this.offset, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect outer = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final Paint shadowPaint = Paint()
      ..color = color.withOpacity(0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    final Path path = Path()..addRRect(outer);

    canvas.saveLayer(rect, Paint()); // Layer for clipping inner shadow

    // Draw full rect as clip
    canvas.clipPath(path);

    // Translate and draw shadow
    canvas.translate(-offset.dx, -offset.dy);
    canvas.drawRRect(outer.shift(offset), shadowPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant InnerShadowPainter oldDelegate) => oldDelegate.blur != blur || oldDelegate.color != color || oldDelegate.offset != offset || oldDelegate.radius != radius;
}
