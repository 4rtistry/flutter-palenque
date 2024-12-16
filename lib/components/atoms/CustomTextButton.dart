import 'package:flutter/material.dart';

enum ButtonVariant { filled, outlined } // Add button variants

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double? width;
  final ButtonVariant variant; // Add the variant property

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0xFFE64A19),
    this.textColor = Colors.white,
    this.borderColor = const Color(0xFFE64A19),
    this.borderRadius = 6.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.0),
    this.textStyle,
    this.width,
    this.variant = ButtonVariant.filled, // Default to filled variant
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutlined = variant == ButtonVariant.outlined;

    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isOutlined
                ? BorderSide(color: borderColor, width: 1.5)
                : BorderSide.none,
          ),
          padding: padding,
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 14.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: isOutlined ? borderColor : textColor,
              ),
        ),
      ),
    );
  }
}
