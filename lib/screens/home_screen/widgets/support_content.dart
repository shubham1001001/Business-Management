// lib/screens/support_chat_screen.dart
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../core/constants/spacing.dart';
import '../../../core/constants/svg_picture_widgets.dart';
import '../../../providers/support_provider/support_provider.dart';

class SupportContent extends StatelessWidget {
  const SupportContent({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<SupportProvider>().messages;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const _PlaceholderWidget()
                : ListView.builder(
                    padding: AppSpacing.allPadding16,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return BubbleSpecialOne(text: messages[index], isSender: true, color: Colors.grey.shade200, textStyle: AppTextStyles.black87Text20);
                    },
                  ),
          ),
          const _ChatInputField(),
        ],
      ),
    );
  }
}

class _PlaceholderWidget extends StatelessWidget {
  const _PlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidgets(svgString: "assets/svg_icons/heart_support_icon.svg"),
          AppSpacing.mediumHeight16,
          Text("Need a hand?", style: AppTextStyles.title),
          AppSpacing.extraSmallHeight,
          Text("We're just a message away", style: AppTextStyles.greyText),
        ],
      ),
    );
  }
}

class _ChatInputField extends StatefulWidget {
  const _ChatInputField();

  @override
  State<_ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<_ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<SupportProvider>().sendMessage(text);
      _controller.clear();
    }
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    print("start....listen");
    if (!_isListening) {
      print("islisten...done");
      bool available = await _speech.initialize(onStatus: (status) => print('Status: $status'), onError: (error) => print('Error: $error'));

      print("start....listen-avalable$available");
      if (available) {
        setState(() => _isListening = true);
        print("start....listen-done");
        _speech.listen(
          onResult: (result) {
            print("listen");
            setState(() {
              _lastWords = result.recognizedWords;
              print("start....listen-$_lastWords");
              _controller.text = _lastWords;
              _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
            });
          },
        );
      }
    } else {
      print("start....listen-stop");
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppSpacing.kSmallRadius,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(context),
                      decoration: InputDecoration(
                        hintStyle: AppTextStyles.greyText.copyWith(color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w500),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        hintText: "Type to chat",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    icon: Transform.rotate(
                      angle: -5.5708, // -45 degrees in radians (negative for counterclockwise)
                      child: Icon(Icons.attach_file, color: AppColors.redColor),
                    ),

                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();

                      if (result != null && result.files.isNotEmpty) {
                        final pickedFile = result.files.first;

                        // ✅ For demonstration: send file name as message
                        context.read<SupportProvider>().sendMessage("📎 File attached: ${pickedFile.name}");

                        // Optional: show file path or content
                        print("Picked file: ${pickedFile.path}");
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 6),
          CircleAvatar(
            backgroundColor: AppColors.redColor,
            radius: 22,
            child: IconButton(
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
              onPressed: _listen,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBubble({required String message, required String time, required bool isSender}) {
  return Align(
    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: CustomPaint(
        painter: ChatBubble(color: isSender ? Colors.red.shade100 : Colors.grey.shade200, alignment: isSender ? Alignment.topRight : Alignment.topLeft),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          constraints: const BoxConstraints(minWidth: 80, maxWidth: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: AppTextStyles.blackBoldText13),
              AppSpacing.extraSmallHeight,
              Align(
                alignment: Alignment.bottomRight,
                child: Text(time, style: AppTextStyles.greyText),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ChatBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;

  ChatBubble({required this.color, required this.alignment});

  final double _radius = 12;
  final double _tailSize = 10;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();

    if (alignment == Alignment.topRight) {
      // 🧑 Sender: tail on top-right
      path.moveTo(0, 0);
      path.lineTo(size.width - _tailSize, 0);
      path.quadraticBezierTo(size.width, 0, size.width, _tailSize); // Tail curve
      path.lineTo(size.width, size.height - _radius);
      path.quadraticBezierTo(size.width, size.height, size.width - _radius, size.height);
      path.lineTo(_radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - _radius);
      path.lineTo(0, _radius);
      path.quadraticBezierTo(0, 0, _radius, 0);
    } else {
      // 🤖 Receiver: tail on top-left
      path.moveTo(_tailSize, 0);
      path.lineTo(size.width, 0);
      path.quadraticBezierTo(size.width, 0, size.width, _radius); // Top-right corner
      path.lineTo(size.width, size.height - _radius);
      path.quadraticBezierTo(size.width, size.height, size.width - _radius, size.height);
      path.lineTo(_radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - _radius);
      path.lineTo(0, _tailSize);
      path.quadraticBezierTo(0, 0, _tailSize, 0); // Tail curve
    }

    canvas.drawShadow(path, Colors.black12, 4.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
