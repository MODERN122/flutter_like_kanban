import 'package:flutter/material.dart';
import 'package:likekanban/styles/colors.dart';

abstract class TextStyles {
  static TextStyle get textfieldBody {
    return TextStyle(fontSize: 16.0);
  }

  static TextStyle get textfieldPlaceholder {
    return TextStyle(fontSize: 14.0);
  }

  static TextStyle get textfieldError {
    return TextStyle(fontSize: 12.0);
  }

  static TextStyle get buttonTextDisabled {
    return TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal);
  }

  static TextStyle get buttonTextEnabled {
    return TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  }

  static TextStyle get cardTitle {
    return TextStyle(fontSize: 12.0);
  }

  static TextStyle get cardBody {
    return TextStyle(fontSize: 16.0);
  }
}
