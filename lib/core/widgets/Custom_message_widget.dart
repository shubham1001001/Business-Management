import 'package:flutter/material.dart';

enum MessageType { success, error, info }

class CustomSnackbar {
  static void show(BuildContext context, {required String message, required MessageType type, Duration duration = const Duration(seconds: 3)}) {
    final backgroundColor = switch (type) {
      MessageType.success => Colors.green.shade600,
      MessageType.error => Colors.red.shade600,
      MessageType.info => Colors.blue.shade600,
    };

    final icon = switch (type) {
      MessageType.success => Icons.check_circle,
      MessageType.error => Icons.error,
      MessageType.info => Icons.info,
    };

    final overlay = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 80,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedSlide(
            offset: const Offset(0, 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlay);

    Future.delayed(duration, () {
      overlay.remove();
    });
  }
}
