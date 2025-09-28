import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_proposal/typing_animator.dart';

class HeaderDisplay extends StatefulWidget {
  const HeaderDisplay(
      {super.key, required this.onOneComplete, required this.onTwoComplete});
  final void Function() onOneComplete;
  final void Function() onTwoComplete;

  @override
  State<HeaderDisplay> createState() => _HeaderDisplayState();
}

class _HeaderDisplayState extends State<HeaderDisplay>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isBigScreen = width > 600;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                (0 / 15) * 0.9,
                min(((0 + 1) / 5) * 0.5, 1.0),
                curve: Curves.easeOut,
              ),
            ),
          ),
          child: SizedBox(
            height: isBigScreen ? 600.h : 390.h,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              // clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://myproposalbucketxclusivecyborg.s3.us-east-1.amazonaws.com/IMG_1415.JPG",
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [
                        0.0,
                        0.7,
                      ],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: .1),
                        Color(0xFF531d2d).withValues(alpha: .7),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TypingAnimator(
                          fullText: 'Forever & Always',
                          speed: Duration(milliseconds: 20),
                          builder: (text) => Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.end,
                              ),
                          onComplete: widget.onOneComplete),
                      TypingAnimator(
                        fullText:
                            'All we needed was God, a gym, and a Flutterwave bottle. Lol!, this has to be the most beautiful love story ever 🥰',
                        speed: Duration(milliseconds: 0),
                        builder: (text) => Text(
                          text,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onComplete: widget.onTwoComplete,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
