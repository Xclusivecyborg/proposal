import 'dart:math';

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
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/our_images%2FIMG_1415.JPG?alt=media&token=bb15b7e2-be1b-4b0f-b9fa-5fa32b29fcbc",
                  // "https://firebasestorage.googleapis.com/v0/b/spinchat-3c35b.appspot.com/o/IMG_2051.JPG?alt=media&token=23b0d4b2-c9f2-41f5-b40c-7080d6a2cd2a",
                  fit: BoxFit.cover,
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
