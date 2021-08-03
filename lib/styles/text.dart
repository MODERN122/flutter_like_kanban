import 'package:flutter/material.dart';
import 'package:likekanban/styles/colors.dart';

abstract class TextStyles {
  static TextStyle get textfieldBody {
    return TextStyle(color: BaseColors.lightGray, fontSize: 16.0);
  }

  static TextStyle get textfieldPlaceholder {
    return TextStyle(color: BaseColors.lightGray, fontSize: 14.0);
  }

  static TextStyle get textfieldError {
    return TextStyle(color: BaseColors.red, fontSize: 12.0);
  }

  static TextStyle get buttonTextDisabled {
    return TextStyle(
        color: BaseColors.lightGray,
        fontSize: 17.0,
        fontWeight: FontWeight.normal);
  }

  static TextStyle get buttonTextEnabled {
    return TextStyle(
        color: BaseColors.darkGray,
        fontSize: 17.0,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get cardTitle {
    return TextStyle(color: BaseColors.pureWhite, fontSize: 12.0);
  }

  static TextStyle get cardBody {
    return TextStyle(color: BaseColors.pureWhite, fontSize: 16.0);
  }
}
