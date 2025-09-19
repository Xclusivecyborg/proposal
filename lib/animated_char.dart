import 'package:flutter/material.dart';

class AnimatedChar extends StatefulWidget {
  const AnimatedChar({
    super.key,
    required this.char,
    this.textStyle,
  });

  final String char;
  final TextStyle? textStyle;

  @override
  State<AnimatedChar> createState() => _AnimatedCharState();
}

class _AnimatedCharState extends State<AnimatedChar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  String char = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _slideAnimation =
        Tween(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (mounted) {
          setState(() {
            char = widget.char;
          });
          _forwardAnimation();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedChar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.char != widget.char) {
      setState(() {
        char = widget.char;
      });
      _forwardAnimation();
    }
  }

  void _forwardAnimation() {
    _animationController
      ..reset()
      ..forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(widget.char, style: widget.textStyle),
          ),
        );
      },
    );
  }
}
