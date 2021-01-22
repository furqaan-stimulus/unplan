import 'package:flutter/material.dart';
import 'package:unplan/utils/view_color.dart';

class TextStyles {
  TextStyles._();

  static const KFontFam = 'Mulish';
  static const _kFontPkg = null;

  static const TextStyle splashTitle1 = TextStyle(
      fontFamily: KFontFam,
      package: _kFontPkg,
      fontStyle: FontStyle.normal,
      fontSize: 36,
      color: ViewColor.text_white_color);

  static const TextStyle loginFooterTitle1 = TextStyle(
      fontFamily: KFontFam,
      package: _kFontPkg,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 36,
      color: ViewColor.button_green_color);

  static const TextStyle splashTitle2 = TextStyle(
      fontFamily: KFontFam,
      package: _kFontPkg,
      fontStyle: FontStyle.normal,
      fontSize: 36,
      color: ViewColor.button_green_color);

  static const TextStyle splashSubTitle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    // fontWeight: FontWeight.w600,
    letterSpacing: 0.65,
    color: ViewColor.button_grey_color,
  );

  static const TextStyle loginFooterSubTitle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.65,
    fontWeight: FontWeight.w600,
    color: ViewColor.text_grey_footer_color,
  );

  static const TextStyle loginTitle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 36,
    color: ViewColor.background_purple_color,
  );

  static const TextStyle emailTextStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.65,
    color: ViewColor.text_black_color,
  );

  static const TextStyle emailHintStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.65,
    color: ViewColor.text_grey_footer_color,
  );

  static const TextStyle passwordTextStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.65,
    color: ViewColor.text_black_color,
  );
  static const TextStyle passwordHintStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.65,
    color: ViewColor.text_grey_footer_color,
  );

  // employee login button text
  static const TextStyle buttonTextStyle1 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 20,
    letterSpacing: 0.5,
    color: ViewColor.background_purple_color,
  );

  // clock in-out button text
  static const TextStyle buttonTextStyle2 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    fontSize: 20,
    color: ViewColor.text_black_color,
  );

  static const TextStyle bottomTextStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.5,
    color: ViewColor.button_green_color,
  );

  static const TextStyle bottomTextStyle2 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_grey_footer_color,
  );

  static const TextStyle bottomTextStyle3 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_green_color,
  );

  static const TextStyle alertTextStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_pink_color,
  );

  static const TextStyle alertTextStyle1 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_red_color,
  );

  // notification text
  static const TextStyle notificationTextStyle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_white_color,
  );

  static const TextStyle notificationTextStyle1 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_pink_color,
  );

  static const TextStyle homeTitle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontSize: 30,
    color: ViewColor.background_purple_color,
  );

  static const TextStyle homeSubTitle = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    color: ViewColor.background_purple_color,
  );

  static const TextStyle homeText = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.text_white_color,
  );

  static const TextStyle homeText1 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: 0.65,
    color: ViewColor.button_green_color,
  );

  static const TextStyle homeText2 = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0.5,
    color: ViewColor.button_green_color,
  );
  static const TextStyle bottomButtonText = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.65,
    fontSize: 20,
    color: ViewColor.button_green_color,
  );

  static const TextStyle homeBottomText = TextStyle(
    fontFamily: KFontFam,
    package: _kFontPkg,
    fontStyle: FontStyle.normal,
    // fontWeight: FontWeight.w600,
    fontSize: 24,
    color: ViewColor.background_purple_color,
  );
}
