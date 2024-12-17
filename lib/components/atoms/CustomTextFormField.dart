import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Color fillColor;
  final Color cursorColor;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry contentPadding;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final double borderRadius;
  final double? iconSize;
  final Color? iconColor;
  final TextCapitalization textCapitalization;
  final bool enabled; // <-- Added this parameter to control enabled state

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
    this.fillColor = const Color(0xFFEEEEEE),
    this.cursorColor = const Color(0xFF212121),
    this.labelStyle,
    this.textStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.borderRadius = 6.0,
    this.iconSize = 20.0,
    this.iconColor = const Color(0xFF9E9E9E),
    this.textCapitalization = TextCapitalization.none,
    this.enabled = true, // <-- Default enabled state is true
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      enabled: enabled, // <-- Make the field disabled if false
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: contentPadding,
        labelStyle: labelStyle ??
            const TextStyle(
              fontSize: 14.0,
              color: Color(0xFF9E9E9E),
              fontFamily: 'Poppins',
            ),
        floatingLabelBehavior: floatingLabelBehavior,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  size: iconSize,
                  color: iconColor,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
      cursorColor: cursorColor,
      style: textStyle ??
          const TextStyle(
            fontSize: 14.0,
            color: Color(0xFF212121),
            fontFamily: 'Poppins',
          ),
      validator: validator,
    );
  }
}
