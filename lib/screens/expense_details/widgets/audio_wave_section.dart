import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../providers/expense_details/expense_details_provider.dart';

class AudioWaveformWidget extends StatefulWidget {
  final String audioUrl;
  const AudioWaveformWidget({super.key, required this.audioUrl});

  @override
  State<AudioWaveformWidget> createState() => _AudioWaveformWidgetState();
}

class _AudioWaveformWidgetState extends State<AudioWaveformWidget> {
  final PlayerController _waveController = PlayerController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ExpenseDetailProvider>(context, listen: false);
    provider.load(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseDetailProvider>(context);

    return Container(
      width: 360,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Waveform
          Expanded(
            child: AudioFileWaveforms(
              size: const Size(double.infinity, 40),
              playerController: _waveController,
              enableSeekGesture: true,
              playerWaveStyle: PlayerWaveStyle(fixedWaveColor: Colors.black, liveWaveColor: Colors.black, spacing: 4, showSeekLine: false, waveCap: StrokeCap.round),
            ),
          ),

          const Icon(Icons.graphic_eq_rounded, size: 40),

          // Duration
          Text(
            "${provider.position.inSeconds.toStringAsFixed(1)} s",
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          AppSpacing.smallWidth,

          // Play/Pause Button
          GestureDetector(
            onTap: () => provider.playPause(),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(color: Color(0xFFE1E1E1), shape: BoxShape.circle),
              child: Icon(provider.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.red, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<ExpenseDetailProvider>(context, listen: false).disposePlayer();
    super.dispose();
  }
}
