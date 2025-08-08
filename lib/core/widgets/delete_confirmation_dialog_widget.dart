import 'package:flutter/material.dart';
import 'package:sales/core/constants/text_styles.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("assets/icons/info_icon_delete_2.png", height: 25),
              SizedBox(width: 8),
              Text("Delete Data", style: AppTextStyles.title16),
            ],
          ),
          const SizedBox(height: 16),
          const Text("This action cannot be undone", style: AppTextStyles.textSize13),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text("Cancel", style: AppTextStyles.appRedText),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text("OK", style: AppTextStyles.appRedText),
                onPressed: () {
                  onConfirm();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
