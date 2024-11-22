import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:you_app/ui/components/text_form_field.dart';

import '../../shared/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget navBack() {
      return Container(
        margin: const EdgeInsets.only(top: 36.0),
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
                fontSize: 14,
                fontWeight: semiBold
              ),
            ),
          ],
        )
      );
    }

    Widget inputSection() {

      Widget loginTitle() {
        return Container(
          margin: EdgeInsets.only(left: navMargin),
          child: 
            Text(
              'Login',
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold
              ),
            ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 60.0),
        padding: EdgeInsets.symmetric(horizontal: secondMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loginTitle(),
            const InputField(
              hintText: ' Username/Email',
              isPassword: false,
            ),
            const InputField(
              hintText: 'Enter Password',
              isPassword: true,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg-gradient.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: navMargin),
            children: [
              navBack(),
              inputSection()
            ],
          )
        ),
      ),
    );
  }
}
