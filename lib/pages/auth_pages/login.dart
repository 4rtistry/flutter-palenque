import 'package:flutter/material.dart';
import 'package:palenque_application/authentication/auth_service.dart';
import 'package:palenque_application/components/molecules/CustomAuthHeader.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/molecules/CustomMediaAuthButton.dart';
import 'package:palenque_application/pages/auth_pages/hero.dart';
import 'package:palenque_application/pages/auth_pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _passwordVisibility = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Prevent overflow when keyboard appears
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
                    text: 'Welcome Back! Log In to Palenque',
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
                            }),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                            controller: passwordController,
                            labelText: 'Password',
                            obscureText: !_passwordVisibility,
                            suffixIcon: _passwordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onSuffixIconPressed: () {
                              setState(() {
                                _passwordVisibility = !_passwordVisibility;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            }),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFFF69C82),
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        Container(
                          child: CustomTextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final String email =
                                    emailController.text.trim();
                                final String password =
                                    passwordController.text.trim();

                                final AuthService authService = AuthService();
                                await authService.signInWithEmailAndPassword(
                                    context, email, password);
                              }
                            },
                            text: 'Login',
                            width: double.infinity,
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
                                'Or Register with',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFFF69C82),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
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
                          height: 174,
                        ),
                        // Bottom Row is fixed, it will not overlap with the keyboard
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account yet?",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Color(0xFFF69C82),
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
