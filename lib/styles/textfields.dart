import 'package:flutter/material.dart';
import 'package:likekanban/styles/base.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/styles/text.dart';

abstract class TextFieldStyles {
  static double get textBoxHorizontal => BaseStyles.horizontal;

  static double get textBoxVertical => BaseStyles.vertical;

  static TextStyle get text => TextStyles.textfieldBody;

  static TextStyle get placeholder => TextStyles.textfieldPlaceholder;

  static Color get cursorColor => BaseColors.lightCyan;

  static TextAlign get textAlign => TextAlign.center;

  static InputDecoration materialDecoration(String hintText, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextFieldStyles.placeholder,
      border: InputBorder.none,
      errorText: errorText,
      errorStyle: TextStyles.textfieldError,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: BaseColors.lightCyan, width: BaseStyles.borderWidth),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: BaseColors.lightGray, width: BaseStyles.borderWidth),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: BaseColors.red, width: BaseStyles.borderWidth),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: BaseColors.red, width: BaseStyles.borderWidth),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
    );
  }
}
