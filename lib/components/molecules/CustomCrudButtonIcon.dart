import 'package:flutter/material.dart';

class CustomCrudButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const CustomCrudButtonIcon({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 14,
        color: const Color(0xFF9E9E9E), // Fixed icon color
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF9E9E9E), // Fixed text color
          fontSize: 14.0,
          fontFamily: 'Poppins', // Fixed font style
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove padding
        backgroundColor: Colors.transparent, // Transparent background
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
        splashFactory: NoSplash.splashFactory, // Disable ripple effect
      ),
    );
  }
}
