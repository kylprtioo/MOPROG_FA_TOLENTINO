import 'package:flutter/material.dart';

class StyledText extends StatelessWidget{
  const StyledText(
    this.text, {
      super.key,
      this.fontSize = 15,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.textColor = Colors.white,
    });

    final String text;
    final double fontSize;
    final FontWeight fontWeight;
    final FontStyle fontStyle;
    final Color textColor;

    @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: textColor,
        letterSpacing: 0.5,
      ),
    );
    }
}