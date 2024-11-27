import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:you_app/cubit/auth_cubit.dart';
import 'package:you_app/cubit/page_cubit.dart';
import 'package:you_app/cubit/user_cubit.dart';
import 'package:you_app/ui/pages/home_page.dart';
import 'package:you_app/ui/pages/interest_edit_page.dart';
import 'package:you_app/ui/pages/login_page.dart';
import 'package:you_app/ui/pages/register_page.dart';
import 'package:you_app/ui/pages/splash_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/interest': (context) => InterestEditPage(),
        },
      ),
    );
  }
}
