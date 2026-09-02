import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOtpInput extends StatefulWidget {
  final String value;
  final int? length;
  final bool autofocus;
  final Function(String) onChanged;

  const AppOtpInput({
    super.key,
    required this.value,
    this.length = 6,
    this.autofocus = false,
    required this.onChanged,
  });

  @override
  State<AppOtpInput> createState() => _AppOtpInputState();
}

class _AppOtpInputState extends State<AppOtpInput> {
  late List<String> _otp;
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    final length = widget.length ?? 6;
    _otp = List<String>.filled(length, "");

    // Initialize OTP array with existing value if any
    for (int i = 0; i < widget.value.length && i < length; i++) {
      _otp[i] = widget.value[i];
    }

    _otpControllers = List<TextEditingController>.generate(
      length,
      (index) => TextEditingController(text: _otp[index]),
    );
    _focusNodes = List<FocusNode>.generate(length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      _otp[index] = value;
      if (index < (widget.length ?? 6) - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      _otp[index] = "";
    }

    widget.onChanged(_otp.join(""));
  }

  @override
  Widget build(BuildContext context) {
    final length = widget.length ?? 6;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          for (var i = 0; i < length; i++)
            SizedBox(
              width: 50,
              child: KeyboardListener(
                focusNode: FocusNode(), // Dummy focus node for listener
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      _otpControllers[i].text.isEmpty &&
                      i > 0) {
                    _focusNodes[i - 1].requestFocus();
                  }
                },
                child: TextField(
                  controller: _otpControllers[i],
                  focusNode: _focusNodes[i],
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  autofocus: widget.autofocus && i == 0,
                  onChanged: (val) => _onChanged(i, val),
                  decoration: const InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder(),
                    counterText: "", // Hide the '0/1' max length counter
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
