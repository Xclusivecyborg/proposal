import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_proposal/core/extension/text_theme.dart';

class EndingText extends StatelessWidget {
  const EndingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withValues(alpha: 0.2),
      ),
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        children: [
          Text(
            "Okay. that's the end for now..😉",
            style: context.textTheme.t14W500,
          ),
          SizedBox(height: 20),
          Text(
            "But not the end of us..🥰",
            style: context.textTheme.t14W500,
          ),
          SizedBox(height: 20),
          Text(
            "I love you today, tomorrow, and the day after ",
            style: context.textTheme.t14W500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "❤️",
            style: context.textTheme.t30W700,
          ),
        ],
      ),
    );
  }
}
