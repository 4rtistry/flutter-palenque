import 'package:flutter/material.dart';
import 'package:palenque_application/authentication/auth_service.dart';
import 'package:palenque_application/components/molecules/CustomAuthHeader.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/molecules/CustomMediaAuthButton.dart';
import 'package:palenque_application/pages/hero/hero.dart';
import 'package:palenque_application/pages/login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _passwordVisiblity = false;
  bool _confirmpasswordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset:
          true, // Ensure the content moves up when keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 350,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CustomAuthHeader(
                    text: 'Join Palenque! Register to Our App Today',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LandingPage()));
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          obscureText: !_passwordVisiblity,
                          suffixIcon: _passwordVisiblity
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconPressed: () {
                            setState(() {
                              _passwordVisiblity = !_passwordVisiblity;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Password must include at least one uppercase letter';
                            }
                            if (!RegExp(r'[a-z]').hasMatch(value)) {
                              return 'Password must include at least one lowercase letter';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Password must include at least one number';
                            }
                            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                .hasMatch(value)) {
                              return 'Password must include at least one special character';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          labelText: 'Confirm Password',
                          obscureText: !_confirmpasswordVisibility,
                          suffixIcon: _confirmpasswordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconPressed: () {
                            setState(() {
                              _confirmpasswordVisibility =
                                  !_confirmpasswordVisibility;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomTextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final String email = emailController.text.trim();
                              final String password =
                                  passwordController.text.trim();

                              final AuthService authService = AuthService();
                              await authService.registerWithEmailandPassword(
                                  context, email, password);
                            }
                          },
                          text: 'Register',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xFFF5F5F5))),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Login with',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                color: Color(0xFFF69C82)),
                          )),
                      Expanded(child: Divider(color: Color(0xFFF5F5F5))),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomMediaAuthButton(
                      svgPath: 'assets/svg/GoogleSVG.svg',
                      text: 'Continue with Google',
                      onPressed: () async {
                        final AuthService authService = AuthService();
                        await authService.signInWithGoogle(context);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomMediaAuthButton(
                      svgPath: 'assets/svg/FacebookSVG.svg',
                      text: 'Continue with Facebook',
                      onPressed: () {}),
                  const SizedBox(
                    height: 145,
                  ),
                  // Bottom Row is fixed, it will not overlap with the keyboard
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xFFF69C82),
                                fontFamily: 'Poppins',
                                fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
