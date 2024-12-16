import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMediaAuthButton extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double textSize;
  final Color borderColor;
  final double borderRadius;

  const CustomMediaAuthButton({
    super.key,
    required this.svgPath,
    required this.text,
    required this.onPressed,
    this.textColor = const Color(0xFF9E9E9E),
    this.textSize = 14.0,
    this.borderColor = const Color(0xFFD9D9D9),
    this.borderRadius = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: borderColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                svgPath,
                width: 20,
                height: 20,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontFamily: 'Poppins',
              ),
            )
          ],
        ),
      ),
    );
  }
}
