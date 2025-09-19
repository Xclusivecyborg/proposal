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
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          alignment: WrapAlignment.end,
          children: List.generate(55, (index) {
            final intIndex = (index % 5) + 1;
            final color = AppColors.red.withValues(alpha: intIndex * 0.8);
            return Icon(
              Icons.favorite,
              color: color,
              size: 30.sp,
            );
          }),
        ),
        SizedBox(height: 20),
        Text(
          'WAIT! ✋🏾',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 30.sp,
          ),
          textAlign: TextAlign.end,
        ),
        Text(
          'Hollup!! ✋🏾',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 35.sp,
          ),
          textAlign: TextAlign.end,
        ),
        Text(
          'Walk with me!!!🚶🏽‍♂️',
          style: context.textTheme.t20W600.copyWith(
            fontSize: 40.sp,
          ),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 50),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: List.generate(
            8,
            (index) {
              return Container(
                width: 80.sp,
                height: 80.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: List.generate(
                      4,
                      (i) {
                        final intIndex = (i % 5) + 1;
                        return AppColors.primaryColor
                            .withValues(alpha: intIndex * 0.8);
                      },
                    ),
                  ),
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
        ),
      ],
    );
  }
}
