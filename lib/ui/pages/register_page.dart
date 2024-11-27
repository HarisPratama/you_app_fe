import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:you_app/cubit/auth_cubit.dart';
import 'package:you_app/ui/components/text_form_field.dart';

import '../../shared/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkButtonState);
    usernameController.addListener(_checkButtonState);
    passwordController.addListener(_checkButtonState);
    confirmPasswordController.addListener(_checkButtonState);
  }

  void _checkButtonState() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.value == confirmPasswordController.value;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget navBack() {
      return Container(
          margin: const EdgeInsets.only(top: 36.0),
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
      Widget registerTitle() {
        return Container(
          margin: EdgeInsets.only(left: navMargin),
          child: Text(
            'Register',
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
                      if (state is AuthSuccessRegister) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content:  Text(state.auth.message)));
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
                                  context.read<AuthCubit>().register(email: emailController.text, username: emailController.text, password: passwordController.text);
                                }
                              : null,
                          child: Text('Register',
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

      Widget loginNav() {
        return Container(
          margin: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Have an account? ',
                style:
                    whiteTextStyle.copyWith(fontWeight: regular, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Login here',
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
        padding: EdgeInsets.symmetric(horizontal: secondMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            registerTitle(),
            InputField(
              controller: emailController,
              hintText: 'Enter Email',
              isPassword: false,
            ),
            InputField(
              controller: usernameController,
              hintText: 'Create Username',
              isPassword: false,
            ),
            InputField(
              controller: passwordController,
              hintText: 'Create Password',
              isPassword: true,
            ),
            InputField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              isPassword: true,
            ),
            submitbutton(),
            loginNav(),
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
          padding: EdgeInsets.symmetric(horizontal: navMargin),
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
