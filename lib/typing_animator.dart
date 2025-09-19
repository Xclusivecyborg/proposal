import 'dart:async';

import 'package:flutter/material.dart';

class TypingAnimator extends StatefulWidget {
  final Widget Function(String text) builder;
  final String fullText;
  final Duration speed;
  final VoidCallback? onComplete;
  final bool repeat;

  const TypingAnimator({
    super.key,
    required this.builder,
    required this.fullText,
    this.speed = const Duration(milliseconds: 100),
    this.onComplete,
    this.repeat = false,
  });

  @override
  State<TypingAnimator> createState() => _TypingAnimatorState();
}

class _TypingAnimatorState extends State<TypingAnimator> {
  String _currentText = "";
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_index < widget.fullText.length) {
        setState(() {
          _currentText += widget.fullText[_index];
          _index++;
        });
      } else {
        timer.cancel();
        widget.onComplete?.call();
        if (widget.repeat) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _currentText = "";
              _index = 0;
            });
            _startTyping();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_currentText);
  }
}
