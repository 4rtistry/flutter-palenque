import 'package:flutter/material.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/pages/auth_pages/login.dart';
import 'package:palenque_application/pages/auth_pages/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/LPbgV3.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/PalenqueLogo.png',
                        height: 45,
                      ),
                      const Text(
                        'From Market to Your Doorstep',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontFamily: 'Poppins',
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    child: CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      text: 'Login',
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      text: 'Register',
                      width: double.infinity,
                      variant: ButtonVariant.outlined,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue as a guest',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
