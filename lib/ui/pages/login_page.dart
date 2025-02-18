import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:you_app/cubit/auth_cubit.dart';
import 'package:you_app/ui/components/text_form_field.dart';

import '../../shared/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkButtonState);
    passwordController.addListener(_checkButtonState);
  }

  void _checkButtonState() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget navBack() {
      return Container(
          margin: const EdgeInsets.only(top: 36.0),
          padding: EdgeInsets.only(left: navMargin),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icon_back_nav.svg', // Path to your SVG file
                  width: 18.0, // Adjust size as needed
                  height: 18.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  'Back',
                  style: whiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                ),
              ],
            ),
          ));
    }

    Widget inputSection() {
      Widget loginTitle() {
        return Container(
          margin: EdgeInsets.only(left: navMargin),
          child: Text(
            'Login',
            style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
          ),
        );
      }

      Widget submitbutton() {
        return Opacity(
          opacity: isButtonEnabled ? 1.0 : 0.5,
          child: Container(
            margin: EdgeInsets.only(top: 25),
            height: 60,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Stack(
              children: [
                if (isButtonEnabled)
                  Positioned(
                    top: 14,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(98, 205, 203, 0.5),
                              Color.fromRGBO(69, 153, 219, 0.5),
                            ],
                            stops: [0.2488, 0.7849],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isButtonEnabled)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      blendMode: BlendMode.overlay,
                      child: Container(
                        color:
                            Colors.transparent, // Required to make blur visible
                      ),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff62CDCB),
                          Color(0xff4599DB),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content:  Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return TextButton(
                          onPressed: isButtonEnabled
                              ? () {
                                  context.read<AuthCubit>().login(email: emailController.text, username: emailController.text, password: passwordController.text);
                                }
                              : null,
                          child: Text('Login',
                              style: whiteTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 16)));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }

      Widget registerNav() {
        return Container(
          margin: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No account? ',
                style:
                    whiteTextStyle.copyWith(fontWeight: regular, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'Register here',
                  style: goldGradientTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(
                        0xFFFFD700), // Set the color of the underline (gold)
                    decorationThickness: 2.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 60.0),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginTitle(),
            InputField(
              controller: emailController,
              hintText: 'Username/Email',
              isPassword: false,
            ),
            InputField(
              controller: passwordController,
              hintText: 'Enter Password',
              isPassword: true,
            ),
            submitbutton(),
            registerNav(),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg-gradient.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: ListView(
          children: [
            navBack(),
            Expanded(
                child: Center(
              child: inputSection(),
            )),
          ],
        )),
      ),
    );
  }
}
