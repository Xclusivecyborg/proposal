import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ThemeText on TextTheme {
  TextStyle get text0 =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);

  TextStyle get text1 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);

  TextStyle get t14W500 =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  TextStyle get t16W500 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);

  TextStyle get t20W600 =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);

  TextStyle get t24W700 =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600);

  TextStyle get t30W700 =>
      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700);
}
