import 'package:audio_waveform_view/audio_waveform_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/svg_picture_widgets.dart';
import '../../../providers/expense_details/expense_details_provider.dart';

class AudioWaveformWidget extends StatefulWidget {
  final String audioUrl;
  const AudioWaveformWidget({super.key, required this.audioUrl});

  @override
  State<AudioWaveformWidget> createState() => _AudioWaveformWidgetState();
}

class _AudioWaveformWidgetState extends State<AudioWaveformWidget> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ExpenseDetailProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseDetailProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Waveform
          Expanded(
            child: SizedBox(
              height: 70,
              width: 400,
              child: CustomPaint(
                painter: WaveformPainter(progress: 0.0, playedColor: Colors.black54, unplayedColor: Colors.grey, max: 1.0, min: 0.0),
              ),
            ),
          ),

          // const Icon(Icons.graphic_eq_rounded, size: 40),
          AppSpacing.smallWidth10,
          // Duration
          Text(
            "${5.8} s",
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          AppSpacing.smallWidth,

          // Play/Pause Button
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: AppColors.playButtonColor, shape: BoxShape.circle),
              child: Stack(
                children: [
                  SvgPictureWidgets(svgString: "assets/svg_icons/play_ring.svg", size: 24.0),
                  Positioned(left: 0, right: 0, top: 3, child: Icon(Icons.play_arrow, color: AppColors.redColor, size: 17)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
