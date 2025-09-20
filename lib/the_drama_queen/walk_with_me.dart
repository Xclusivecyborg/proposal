import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_proposal/core/colors/app_colors.dart';
import 'package:my_proposal/core/extension/text_theme.dart';
import 'package:my_proposal/typing_animator.dart';

class WalkWithMe extends StatelessWidget {
  const WalkWithMe({super.key});

  @override
  Widget build(BuildContext context) {
    String text = 'DrumRoll';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'WAIT! ✋🏾',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.end,
        ),
        Text(
          'Hollup!! ✋🏾',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 25.sp,
          ),
          textAlign: TextAlign.end,
        ),
        Text(
          'Walk with me!!!🚶🏽‍♂️',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 35.sp,
          ),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 50),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (text.length / 2).ceil(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: text.length,
          itemBuilder: (context, index) {
            final intIndex = (index % 5) + 1;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              child: Center(
                child: Text(
                  text[index],
                  style: context.textTheme.t30W700.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class WhoIsGummyBear extends StatelessWidget {
  const WhoIsGummyBear({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        TypingAnimator(
          fullText: 'Who is my Gummy Bear ???',
          speed: Duration(milliseconds: 50),
          builder: (text) => Text(
            text,
            style: context.textTheme.t24W700,
          ),
          onComplete: () {},
          repeat: true,
        ),
        SizedBox(height: 50),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final intIndex = (index % 5) + 1;
            final color = AppColors.red.withValues(alpha: intIndex * 0.8);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: color,
                  size: 70.sp,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
