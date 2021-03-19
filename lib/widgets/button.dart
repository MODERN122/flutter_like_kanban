import 'package:flutter/material.dart';
import 'package:likekanban/styles/base.dart';
import 'package:likekanban/styles/buttons.dart';
import 'package:likekanban/styles/colors.dart';
import 'package:likekanban/styles/text.dart';

enum ButtonType { Enabled, Disabled }

class ExtendedButton extends StatefulWidget {
  final String buttonText;
  final ButtonType buttonType;
  final void Function() onPressed;

  ExtendedButton({@required this.buttonText, this.buttonType, this.onPressed});

  @override
  _ExtendedButtonState createState() => _ExtendedButtonState();
}

class _ExtendedButtonState extends State<ExtendedButton> {
  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    Color buttonColor;

    switch (widget.buttonType) {
      case ButtonType.Enabled:
        fontStyle = TextStyles.buttonTextEnabled;
        buttonColor = BaseColors.lightCyan;
        break;
      case ButtonType.Disabled:
        fontStyle = TextStyles.buttonTextDisabled;
        buttonColor = BaseColors.lightCyan;
        break;
      default:
        fontStyle = TextStyles.buttonTextDisabled;
        buttonColor = BaseColors.lightCyan;
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: BaseStyles.horizontal, vertical: BaseStyles.vertical),
      child: GestureDetector(
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
          ),
          child: Center(
              child: Text(
            widget.buttonText,
            style: fontStyle,
          )),
        ),
        onTap: () {
          if (widget.buttonType != ButtonType.Disabled) {
            widget.onPressed();
          }
        },
      ),
    );
  }
}
