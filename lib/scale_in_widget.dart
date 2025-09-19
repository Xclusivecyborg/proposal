import 'package:flutter/cupertino.dart';

class ScaleInWidget extends StatefulWidget {
  const ScaleInWidget({
    required this.child,
    super.key,
    this.duration = 500,
    this.delay = 0,
  });
  final Widget child;
  final int duration;
  final int delay;
  @override
  State<ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<ScaleInWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ScaleTransition(
          scale: _animation,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
