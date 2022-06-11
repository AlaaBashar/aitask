import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final double? horizontalPadding;
  final Color? color;
  final Function()? onPressed;

  const DefaultButtonWidget({
    Key? key,
    required this.text,
    this.height,
    this.color,
    required this.onPressed,
    this.textColor,
    this.horizontalPadding,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: MaterialButton(
        minWidth: double.infinity,
        color: color ?? Colors.grey,
        height: height ?? 50.0,
        textColor: textColor ?? Colors.white,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize ?? 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
