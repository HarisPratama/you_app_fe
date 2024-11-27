import 'dart:async';

import 'package:flutter/material.dart';
import 'package:you_app/services/auth_service.dart';
import 'package:you_app/shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
  
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final accessToken = await AuthService().getAccessToken();

    Timer(Duration(seconds: 3), () {
      if (accessToken != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg-gradient.png'),
            fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text('YouApp', style: whiteTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold
            ),),
          ),
        ),
      ),
    );
  }
}