import 'package:flutter/material.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 150,
        child: CustomTextButton(
          onPressed: () {},
          text: ' Temporary Sign Out',
          width: double.infinity,
          variant: ButtonVariant.outlined,
        ),
      ),
    );
  }
}
