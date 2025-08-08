import 'package:flutter/material.dart';
import 'package:sales/core/constants/text_styles.dart';

class OtpInputScreen extends StatefulWidget {
  List<TextEditingController> controllers;
  OtpInputScreen({super.key, required this.controllers});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in widget.controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 1.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: screenWidth * 0.19,
              child: TextField(
                controller: widget.controllers[index],
                focusNode: _focusNodes[index],
                maxLength: 1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: AppTextStyles.blackBoldText24.copyWith(fontSize: 30, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  counterText: '',
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.5), width: 1.8)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.7), width: 1.5)),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            );
          }),
        ),
      ),
    );
  }
}
