import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_proposal/core/colors/app_colors.dart';
import 'package:my_proposal/core/extension/text_theme.dart';

class BeforeWeProceed extends StatefulWidget {
  const BeforeWeProceed({super.key, required this.onAnswer});
  final void Function(bool) onAnswer;

  @override
  State<BeforeWeProceed> createState() => _BeforeWeProceedState();
}

class _BeforeWeProceedState extends State<BeforeWeProceed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(35.0.r),
      margin: EdgeInsets.symmetric(vertical: 24.0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Before We Proceed, I have a quick question for you",
            style: context.textTheme.t16W500.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "💍 ",
            style: context.textTheme.t30W700
                .copyWith(color: AppColors.primaryColor),
          ),
          Text(
            "Will you marry me? ",
            style: context.textTheme.t30W700
                .copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 10,
                  onPressed: () => widget.onAnswer(true),
                  color: Colors.pink,
                  child: Padding(
                    padding: EdgeInsets.all(24.0.r),
                    child: Text(
                      "Yes",
                      style: context.textTheme.t14W500.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  onPressed: () => widget.onAnswer(false),
                  color: Colors.blueGrey.withValues(alpha: .1),
                  child: Padding(
                    padding: EdgeInsets.all(24.0.r),
                    child: Text(
                      "No",
                      style: context.textTheme.t14W500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
